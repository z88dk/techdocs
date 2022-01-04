; Tandy M100 / Kyotronic KC85 / Olivetti M10  ROM disassembly

; z80asm -b -m -DM100 -oM100.ROM m100.asm
; z80asm -b -m -DKC85 -oKC85.ROM m100.asm
; z80asm -b -m -DM10 -oM10.ROM m100.asm



defc CR = 13
defc LF = 10


; --- Prefixes, Tokens.. --- 

defc OCTCON   = 11  ; $0B - EMBEDED OCTAL CONSTANT

defc CONCON   = 09  ; $09 - TOKEN RETURNED BY CHRGET AFTER CONSTANT SCANNED


;-------------------------------------------------------------------------------------------------

defc ONEFUN      =  TK_SGN


defc TK_END      =  $80
defc TK_FOR      =  $81
defc TK_NEXT     =  $82
defc TK_DATA     =  $83
defc TK_INPUT    =  $84
defc TK_DIM      =  $85
defc TK_READ     =  $86
defc TK_LET      =  $87
defc TK_GOTO     =  $88
defc TK_RUN      =  $89
defc TK_IF       =  $8A
defc TK_RESTORE  =  $8B
defc TK_GOSUB    =  $8C
defc TK_RETURN   =  $8D
defc TK_REM      =  $8E
defc TK_STOP     =  $8F

defc TK_WIDTH    =  $90
defc TK_ELSE     =  $91
defc TK_LINE     =  $92
defc TK_EDIT     =  $93
defc TK_ERROR    =  $94
defc TK_RESUME   =  $95
defc TK_OUT      =  $96
defc TK_ON       =  $97
defc TK_DSKO_S   =  $98
defc TK_OPEN     =  $99
defc TK_CLOSE    =  $9A
defc TK_LOAD     =  $9B
defc TK_MERGE    =  $9C
defc TK_FILES    =  $9D
defc TK_SAVE     =  $9E
defc TK_LFILES   =  $9F

defc TK_LPRINT   =  $A0
defc TK_DEF      =  $A1
defc TK_POKE     =  $A2
defc TK_PRINT    =  $A3
defc TK_CONT     =  $A4
defc TK_LIST     =  $A5
defc TK_LLIST    =  $A6
defc TK_CLEAR    =  $A7
defc TK_CLOAD    =  $A8
defc TK_CSAVE    =  $A9
defc TK_TIME_S   =  $AA
defc TK_DATE_S   =  $AB
defc TK_DAY_S    =  $AC
defc TK_COM      =  $AD
defc TK_MDM      =  $AE
defc TK_KEY      =  $AF

defc TK_CLS      =  $B0
defc TK_BEEP     =  $B1
defc TK_SOUND    =  $B2
defc TK_LCOPY    =  $B3
defc TK_PSET     =  $B4
defc TK_PRESET   =  $B5
defc TK_MOTOR    =  $B6
defc TK_MAX      =  $B7
defc TK_POWER    =  $B8
defc TK_CALL     =  $B9
defc TK_MENU     =  $BA
defc TK_IPL      =  $BB
defc TK_NAME     =  $BC
defc TK_KILL     =  $BD
defc TK_SCREEN   =  $BE
defc TK_NEW      =  $BF


defc TK_TAB      =  $C0
defc TK_TO       =  $C1
defc TK_USING    =  $C2
defc TK_VARPTR   =  $C3
defc TK_ERL      =  $C4
defc TK_ERR      =  $C5
defc TK_STRING_S =  $C6
defc TK_INSTR    =  $C7
defc TK_DSKI_S   =  $C8
defc TK_INKEY_S  =  $C9
defc TK_CSRLIN   =  $CA
defc TK_OFF      =  $CB
defc TK_HIMEM    =  $CC
defc TK_THEN     =  $CD
defc TK_NOT      =  $CE
defc TK_STEP     =  $CF


; OPERATORS

defc TK_PLUS     =  $D0	; Token for '+'
defc TK_MINUS    =  $D1	; Token for '-'
defc TK_STAR     =  $D2	; Token for '*'
defc TK_SLASH    =  $D3	; Token for '/'

; 8K OPERATORS

defc TK_EXPONENT =  $D4	; Token for '^'
defc TK_AND      =  $D5	; Token for 'AND'
defc TK_OR       =  $D6	; Token for 'OR'

; EXTENDED OPERATORS

defc TK_XOR      =  $D7	; Token for 'XOR'
defc TK_EQV      =  $D8	; Token for 'EQV'
defc TK_IMP      =  $D9	; Token for 'IMP'
defc TK_MOD      =  $DA	; Token for 'MOD'
defc TK_BKSLASH  =  $DB	; Token for '\'

; RELATIONAL OPERATORS

defc TK_GREATER  =  $DC ; Token for '>'
defc TK_EQUAL    =  $DD ; Token for '='
defc TK_MINOR    =  $DE	; Token for '<'


defc TK_SGN      =  $DF
defc TK_INT      =  $E0
defc TK_ABS      =  $E1
defc TK_FRE      =  $E2
defc TK_INP      =  $E3
defc TK_LPOS     =  $E4
defc TK_POS      =  $E5
defc TK_SQR      =  $E6
defc TK_RND      =  $E7
defc TK_LOG      =  $E8
defc TK_EXP      =  $E9
defc TK_COS      =  $EA
defc TK_SIN      =  $EB
defc TK_TAN      =  $EC
defc TK_ATN      =  $ED
defc TK_PEEK     =  $EE
defc TK_EOF      =  $EF

defc TK_LOC      =  $F0
defc TK_LOF      =  $F1
defc TK_CINT     =  $F2
defc TK_CSNG     =  $F3
defc TK_CDBL     =  $F4
defc TK_FIX      =  $F5
defc TK_LEN      =  $F6
defc TK_STR_S    =  $F7
defc TK_VAL      =  $F8
defc TK_ASC      =  $F9
defc TK_CHR_S    =  $FA
defc TK_SPACE_S  =  $FB
defc TK_LEFT_S   =  $FC
defc TK_RIGHT_S  =  $FD
defc TK_MID_S    =  $FE

defc TK_APOSTROPHE  =  $FF

;; defc LSTOPK      =  TK_BKSLASH+1-TK_PLUS



;-------------------------------------------------------------------------------------------------


defc MAXRAM      = $F5F0
defc STACK_INIT  = MAXRAM-10

defc ATIDSV        = $F5F2
defc HIMEM         = $F5F4
defc BOOT_VECT     = $F5F6
defc BARCODE       = $F5F9
defc UART          = $F5FC
defc TIMER         = $F5FF
defc _TRAP         = $F602

defc EXTROM_TST    = $F605
defc OPTROM        = $F62A


;---------------------------------
; Computing the HOOK vector table
;---------------------------------

defc HCLEAR        = RST38_VECT+HC_CLEAR  ; used by __CLEAR
defc HMAXRAM       = RST38_VECT+HC_MAXRAM ; 
defc HCHGE         = RST38_VECT+HC_CHGE   ; Allow access to other devices than the internal keyboard
defc HCHSNS        = RST38_VECT+HC_CHSNS  ; 
defc HOUTD         = RST38_VECT+HC_OUTD   ; 
;defc HLCDPUT       = RST38_VECT+HC_LCDPUT
defc HLPTO         = RST38_VECT+HC_LPTO   ; Hook for LPTOUT std routine
defc HSETF         = RST38_VECT+HC_SETF   ; Hook 2 for Locate FCB
defc HINDSKC       = RST38_VECT+HC_INDSKC ; Hook for "read byte"
defc HRSLF         = RST38_VECT+HC_RSLF   ; Hook for "INPUT$"
defc HBAKU         = RST38_VECT+HC_BAKU   ; Hook for "LINE INPUT#"
defc HNTFL         = RST38_VECT+HC_NTFL   ; Close I/O buffer
defc HSAVE         = RST38_VECT+HC_SAVE   ; Hook for "SAVE"
defc HNOFO         = RST38_VECT+HC_NOFO   ; "OPEN": not found
defc HMERG         = RST38_VECT+HC_MERG   ; Hook for "MERGE/LOAD"
defc HNULO         = RST38_VECT+HC_NULO   ; Hook for "OPEN"
defc HGETP         = RST38_VECT+HC_GETP   ; Hook 1 for Locate FCB
defc HFILOU        = RST38_VECT+HC_FILOU  ; 
defc HBINS         = RST38_VECT+HC_BINS   ; Hook 2 for "SAVE"
defc HBINL         = RST38_VECT+HC_BINL   ; Hook for "MERGE/LOAD"
defc HEOF          = RST38_VECT+HC_EOF    ; Init Hook for LOC, LOF, EOF, FPOS
defc HPARD         = RST38_VECT+HC_PARD   ; Hook 1 for "Parse device name" event
defc HNODE         = RST38_VECT+HC_NODE   ; Hook 2 for "Parse device name" event
defc HDEVNAM       = RST38_VECT+HC_DEVNAM ; Extra Hook for "Parse device name" event
defc HPOSD         = RST38_VECT+HC_POSD   ; Hook 3 for "Parse device name" event
defc HGEND         = RST38_VECT+HC_GEND   ; I/O function dispatcher
;    HFILES 
;defc HFILES        = RST38_VECT+HC_FILES
;defc HCHGCON       = RST38_VECT+HC_CHGCON
;    HMSVB  
;    HMSVC  
;    HMLDB  
;    HMLDC  
;    HPCPINL
;    HPCINL 
;    HCHKHIM
;    HESCAPE
;    HTELFNK
;    HTRMST 
defc HTRMF6        = RST38_VECT+HC_TRMF6  ; Terminal, F6 function key
defc HTRMF7        = RST38_VECT+HC_TRMF7  ; Terminal, F7 function key
;defc HTRMEND       = RST38_VECT+HC_TRMEND
;defc HCOMOPN       = RST38_VECT+HC_COMOPN
;defc HCOMCLS       = RST38_VECT+HC_COMCLS
;defc HSD232C       = RST38_VECT+HC_SD232C
;    HMPXSEL
;    HTELERR
;    HPRTTTL
defc HUPLD         = RST38_VECT+HC_UPLD   ; Terminal, EOF/UPLOAD related hook
defc HTEXT         = RST38_VECT+HC_TEXT   ; Terminal, ESC/TEXT handling related hook
defc HWIDT         = RST38_VECT+HC_WIDT   ; Hook for "WIDTH" statemen
;defc HCRTPUT       = RST38_VECT+HC_CRTPUT ; 
defc HSCRE         = RST38_VECT+HC_SCRE   ; Hook for "SCREEN"
defc HTVOPN        = RST38_VECT+HC_TVOPN  ; CRT open routine
;    HTVCLS
defc HTVOUT        = RST38_VECT+HC_TVOUT  ; CRT output file routine
;    HTVINP
;    HTVBCK
defc HWAOPN        = RST38_VECT+HC_WAOPN  ; WAND Open routine
defc HWACLS        = RST38_VECT+HC_WACLS  ; WAND Close routine
defc HWAINP        = RST38_VECT+HC_WAINP  ; WAND Get routine
defc HWABCK        = RST38_VECT+HC_WABCK  ; WAND Special I/O
defc HLOF          = RST38_VECT+HC_LOF    ; Hook for "LOF"
defc HLOC          = RST38_VECT+HC_LOC    ; Hook for "LOC"
defc HFILE         = RST38_VECT+HC_FILE   ; Hook for "LFILES"
defc HDSKI         = RST38_VECT+HC_DSKI   ; Hook for "DSKI$"
defc HDSKO         = RST38_VECT+HC_DSKO   ; Hook for "DSKO$"
defc HKILL         = RST38_VECT+HC_KILL   ; Hook for "KILL"
defc HNAME         = RST38_VECT+HC_NAME   ; Hook for "NAME"
defc HMSAVE        = RST38_VECT+HC_MSAVE  ; Hook for "SAVEM"
defc HMLOAD        = RST38_VECT+HC_MLOAD  ; Hook for "LOAD"


defc LCD_DEVTYPE  = $FF
defc CRT_DEVTYPE  = $FE
defc CAS_DEVTYPE  = $FD
defc COM_DEVTYPE  = $FC
defc WAND_DEVTYPE = $FB
defc LPT_DEVTYPE  = $FA


;---------------------------------
;          OLIVETTI M10
;---------------------------------

IF M10

defc PARM1        = $FBEA
defc PARM2        = $FBEF

ENDIF


;---------------------------------
;    Kyocera/Kyotronic KC-85
;---------------------------------

IF KC85 | M10

defc RAM_DEVTYPE  = $F9


defc TELCOM_TBL_PIVOT  = $F62C
defc TEL_F6_PIVOT      = $F62E

defc FNKPNT        = $F633
defc PASPNT        = $F635
defc FNKSWI        = $F636
defc FNKSTAT       = $F637
defc SCREEN        = $F63F
defc CSRX          = $F640
defc CSRY          = $F641
defc ACTV_X        = $F642
defc ACTV_Y        = $F643
defc LABEL_LN      = $F644
defc NO_SCROLL     = $F645
defc CSR_STATUS    = $F646
defc CSR_ROW       = $F647
defc CSR_COL       = $F648
defc ESCCNT        = $F64D
defc ESCSAV        = $F64E
defc REVERSE       = $F64F
defc TXT_WIDTH     = $F650

defc FNK_FLAG      = $F657
defc TXT_ASKBUF    = $F651
defc GR_X          = $F655
defc GR_Y          = $F656
defc EDITMODE      = $F658
defc ERRTRP        = $F659
defc ONGSBF        = $F65B
defc ONDATEF       = $F65C
defc POWR_FLAG     = $F65D
defc PWRINT        = $F65E
defc DUPLEX        = $F65F
defc ECHO          = $F660
defc RS232LF       = $F661
defc STAT          = $F662
defc PIVOTCALL     = $F667
defc _OUT          = $F66E
defc OTPORT        = $F66F
defc _INP          = $F671
defc INPORT        = $F672
defc ENDPRG        = $F674
defc ERR_CODE      = $F679
defc LPTPOS       = $F67B
defc PRTFLG        = $F67C
defc CLMLST        = $F67D
defc STKTOP        = $F67F
defc CURLIN        = $F681
defc BASTXT        = $F683
defc VLZADR        = $F685
defc BUFFER        = $F687
defc INPBFR        = $F688
defc BUFMIN        = $F68B
defc KBUF          = $F68C

defc EDTVARS       = $F6E6

defc TXT_ERRFLG    = $F6E8
defc TXT_SEL_BEG   = $F6E9
defc TXT_SEL_END   = $F6EB
defc TXT_BUFLAG    = $F6ED
defc SAVE_CSRX     = $F6EE
defc STRG_ASKBUF   = $F726
defc TXT_ESCADDR   = $F76C
defc CUR_TXTFILE   = $F76E
defc ENDBUF        = $F78E
defc TTYPOS        = $F78F
defc FNKSTR        = $F790
defc FILETYPE      = $F810
defc IPLBBUF       = $F811
defc PASTE_BUF     = $F893

defc SHFT_PRINT    = $F891
defc TXT_SAVPTR    = $F895
defc TXT_COUNT     = $F897
defc TXT_PTR       = $F899
defc TXT_BUF       = $F89B
defc TXT_EDITING   = $F927
defc BASICMODE     = $F928
defc TRM_WIDTH     = $F929
defc SECS          = $F92A
defc SECS_2        = $F92B
defc MINS          = $F92C
defc MINS_2        = $F92D
defc HRS           = $F92E
defc HRS_2         = $F92F
defc DATE          = $F930
defc DATE_2        = $F931
defc DAY           = $F932
defc MONTH         = $F933
defc YEAR          = $F934
defc YEAR_2        = $F935
defc CSRITP        = $F936
defc TIMCN2        = $F937
defc TIMINT        = $F938
defc TMOFLG        = $F939
defc CLOCK_SS1     = $F93A
defc CLOCK_SS2     = $F93B
defc CLOCK_MM1     = $F93C
defc CLOCK_MM2     = $F93D
defc CLOCK_HH1     = $F93E
defc CLOCK_HH2     = $F93F
defc CLOCK_DT1     = $F940
defc CLOCK_DT2     = $F941
defc CLOCK_DAY     = $F942
defc ON_DATE       = $F943
defc ON_TIME_TM    = $F944

; --------------------------------------------------------------------------
; TRPTBL () - Data table for the interrupt facilities (78 bytes on MSX).
; *_FLG byte meaning (on MSX):
;                  Bit 7-3 - unused
;                  Bit 2   - Interrupt occurred Y/N   1= Yes
;                  Bit 1   - Interrupt STOP  Y/N      1= Yes
;                  Bit 0   - Interrupt OFF Y/N        1= No

defc TRPTBL        = $F94B
defc ON_COM_ADDR   = $F94C
defc ON_COM        = $F950
defc ON_TIME_FLG   = $F94E
defc ON_TIME       = $F94F
defc DIRECTORY     = $F969

IF M10
defc SCHDIR        = $F995
defc SUZUKI        = $F9A1
defc HAYASHI       = $F9AC
defc EDTDIR        = $F9B7
ELSE
defc SCHDIR        = $F97F
defc SUZUKI        = $F98B
defc HAYASHI       = $F996
defc EDTDIR        = $F9A1
ENDIF

defc USRDIR        = $F9C1
defc END_DIR       = $FA80
defc DIRPNT        = $FA93
defc CASPRV        = $FA95
defc COMPRV        = $FA96
defc RAMPRV        = $FA98
defc PASPRV        = $FAA8
defc RAMFILE       = $FAA9
defc OPTROM_SIG    = $FAAB
defc LPRINT_CH     = $FAB3
defc LBL_LINE      = $FAB4
defc PORT_A8       = $FAB5
defc IPL_FNAME     = $FAB6
defc LBLIST        = $FAC1
defc LBEDIT        = $FAC3
defc STAKSV        = $FAC5
defc RAM           = $FAC7
defc CAPTUR        = $FAC9
defc SV_TXTPOS     = $FACB
defc FNAME_END     = $FACD
defc CRTFLG        = $FACE
defc MENU_FLG      = $FACF
defc RST38_OFFS    = $FAD0
defc SV_CSRY       = $FAD1
defc BLINK         = $FAD2
defc SV_LABEL_LN   = $FAD3
defc TOP           = $FAD4
defc PRLEN         = $FAD6
defc EXE           = $FAD8
defc RAM_FILES     = $FADE


defc RST38_VECT    = $FAE0	; -----  HOOK CODE VECTOR (NEC equivalent listed) -----

defc HLCDPUT       = RST38_VECT+HC_LCDPUT	; 10
defc HFILES        = RST38_VECT+HC_FILES
defc HCHGCON       = RST38_VECT+HC_CHGCON

defc HTRMEND       = RST38_VECT+HC_TRMEND
defc HCOMOPN       = RST38_VECT+HC_COMOPN
defc HCOMCLS       = RST38_VECT+HC_COMCLS
defc HSD232C       = RST38_VECT+HC_SD232C

defc HC_CLEAR   = 00
defc HC_MAXRAM  = 02
defc HC_CHGE    = 04
defc HC_CHSNS   = 06
defc HC_OUTD    = 08

defc HC_LCDPUT  = 10

defc HC_LPTO    = 12
defc HC_SETF    = 14
defc HC_INDSKC  = 16
defc HC_RSLF    = 18
defc HC_BAKU    = 20
defc HC_NTFL    = 22
defc HC_SAVE    = 24
defc HC_NOFO    = 26
defc HC_MERG    = 28
defc HC_NULO    = 30
defc HC_GETP    = 32
defc HC_FILOU   = 34
defc HC_BINS    = 36
defc HC_BINL    = 38
defc HC_EOF     = 40
defc HC_PARD    = 42
defc HC_NODE    = 44
defc HC_DEVNAM  = 46
defc HC_POSD    = 48
defc HC_GEND    = 50
defc HC_FILES   = 52
defc HC_CHGCON  = 54
defc HC_TRMF6   = 56
defc HC_TRMF7   = 58
defc HC_TRMEND  = 60
defc HC_COMOPN  = 62
defc HC_COMCLS  = 64
defc HC_SD232C  = 66
defc HC_UPLD    = 68
defc HC_TEXT    = 70
defc HC_WIDT    = 72
defc HC_SCRE    = 74
defc HC_TVOPN   = 76
;defc HC_TVCLS     = 78
defc HC_TVOUT   = 80
defc HC_WAOPN   = 82
defc HC_WACLS   = 84
defc HC_WAINP   = 86
defc HC_WABCK   = 88
defc HC_LOF     = 90
defc HC_LOC     = 92
defc HC_FILE    = 94
defc HC_DSKI    = 96
defc HC_DSKO    = 98
defc HC_KILL    = 100
defc HC_NAME    = 102
defc HC_MSAVE   = 104
defc HC_MLOAD   = 106


defc TEXT_END      = $FB74
;
; IN GETTING A POINTER TO A VARIABLE IT IS IMPORTANT TO REMEMBER WHETHER IT
; IS BEING DONE FOR "DIM" OR NOT DIMFLG AND VALTYP MUST BE CONSECUTIVE LOCATIONS
;
defc DIMFLG        = $FB76
defc VALTYP        = $FB77      ; (word) type indicator  (IN THE 8K 0=NUMERIC 1=STRING)
defc OPRTYP        = $FB78      ; Also used as "DORES" by the (de)tokenizer
defc MEMSIZ        = $FB79      ; Highest location in memory used by BASIC
defc TEMPPT        = $FB7B      ; (word), start of free area of temporary descriptor
defc TEMPST        = $FB7D      ; Temporary descriptors
defc VARIABLES     = $FB8B      ; Storage area for BASIC variables
defc DSCTMP        = $FB9B      ; String descriptor which is the result of string fun
defc TMPSTR        = $FB9C      ; Temporary string
defc FRETOP        = $FB9E      ; Starting address of unused area of string area

defc ENDFOR        = $FBA4      ; NEXT address of FOR statement
defc DATLIN        = $FBA6      ; Line number of DATA st.read by READ st.
defc SUBFLG        = $FBA8      ; (byte), flag for USR fn. array
defc AUTFLG        = $FBA9
defc FLGINP        = $FBAA      ; Flag for INPUT or READ
defc TEMP          = $FBAB      ; (word) temp. reservation for st.code
defc TEMP3         = $FBA0
defc TEMP8         = $FBA2      ; Used for garbage collection

defc SAVTXT        = $FBAD      ; PTR to recent or running line (e.g. used by RESUME)
defc SAVSTK        = $FBAF      ; Save stack when error occurs
defc ERRLIN        = $FBB1      ; Line where last error occurred
defc DOT           = $FBB3      ; Current line for edit & list
defc ERRTXT        = $FBB5      ; Error messages text table
defc ONELIN        = $FBB7      ; ON ERROR line
defc ONEFLG        = $FBB9      ; ON ERROR status flag
defc NXTOPR        = $FBBA      ; a.k.a. TEMP2, Address ptr to next operator, used by EVAL
defc OLDLIN        = $FBBC      ; old line number set up ^C ...
defc OLDTXT        = $FBBE      ; Points st. to be executed next
defc DO_FILES      = $FBC0
defc CO_FILES      = $FBC2
defc VARTAB        = $FBC4		; BASIC program end ptr (a.k.a. PROGND, Simple Variables)
defc VAREND        = $FBC6      ; End of variables (aka ARYTAB), begin of array aariables
defc STREND        = $FBC8      ; End of arrays (a.k.a. ARREND lowest free mem)
defc DATPTR        = $FBCA      ; Pointer used by READ to get DATA stored in BASIC PGM
defc DEFTBL        = $FBCC      ; Default valtype for each letter (26 bytes)
defc PRMSTK        = $FBE6      ; (word), previous block definition on stack
defc PRMLEN        = $FBE8      ; (word), number of bytes of obj table
; PARM1
defc PRMPRV        = $FBEB      ; Pointer to previous parameter block
defc PRMLN2        = $FBED      ; (word), size of parameter block
; PARM2
defc ARYTA2        = $FBF1      ; End point of search

IF M10
defc PRMFLG        = $FBF0      ; Flag to indicate whether PARM1 was searching
ELSE
defc PRMFLG        = $FBF2      ; Flag to indicate whether PARM1 was searching
ENDIF

defc NOFUNS        = $FBF3      ; (byte), 0 if no function active
defc TEMP9         = $FBF4      ; Location of temporary storage for garbage collection
defc FUNACT        = $FBF6      ; (word), active functions counter
defc VLZDAT        = $FBF8

defc FBUFFR        = $FBF9
defc NUMSTR        = $FBFA
defc DECTMP        = $FC24
defc DECTM2        = $FC26
defc DECCNT        = $FC28
defc FACCU         = $FC2A
defc FACLOW        = $FC2C
defc HOLD8         = $FC3A  ; (48 bytes) Double precision operations work area
defc HOLD2         = $FC6A
defc HOLD          = $FC72
defc ARG           = $FC7B
defc ARG_INT       = $FC7D
defc RNDX          = $FC8B
defc SEEDRD        = $FC8C

defc MAXFIL        = $FC94
defc FILTAB        = $FC95
defc PTRFIL        = $FC9E
defc FILFLG        = $FCA4
defc FILNAM        = $FCA5
defc FILNM2        = $FCAE
defc NLONLY        = $FCB9
defc ALT_LCD       = $FCC0
defc MENUVARS      = $FDD7
defc SV_SCREEN     = $FDFA
defc BEGLCD        = $FE00
defc ENDLCD        = $FF40
defc XONXOFF       = $FF41
defc XONXOFF_FLG   = $FF42
defc RS232_FLG     = $FF43
defc SOUND_FLG     = $FF44
defc ROMSEL        = $FF46

IF M10
defc RS232_BUF     = $FFA1
ELSE
defc RS232_BUF     = $FFBE
ENDIF

defc RS232_COUNT   = $FF47
defc CTRL_S_FLG    = $FF4B
defc RS232_BAUD    = $FF4C
defc COMMSK        = $FF4E
defc CASS_HILO     = $FF4F
defc KBSITP        = $FF50
defc REPCNT        = $FF51
defc KYDATA        = $FF52


IF M10
defc KB_SHIFT      = $FF65
defc KYHOW         = $FF66
defc KYREPT        = $FF67
defc KYWHAT        = $FF68
defc KYBCNT        = $FF6D
defc KYRDBF        = $FF6E
defc BRKCHR        = $FF8E
defc SHAPE         = $FF90
defc CSRSTS        = $FF96
defc CSRCNT        = $FF97
defc LCD_ADDR      = $FF98
defc GFX_TEMP      = $FF9A
defc SAVSP         = $FF9C
defc IOFLAGS       = $FF9E
ELSE
defc KB_SHIFT      = $FF63
defc KYHOW         = $FF64
defc KYREPT        = $FF65
defc KYWHAT        = $FF66
defc KYBCNT        = $FF6B
defc KYRDBF        = $FF6C
defc BRKCHR        = $FFAC
defc SHAPE         = $FFAD
defc CSRSTS        = $FFB3
defc CSRCNT        = $FFB4
defc LCD_ADDR      = $FFB5
defc GFX_TEMP      = $FFB7
defc SAVSP         = $FFB9
defc IOFLAGS       = $FFBB
ENDIF

ENDIF



;---------------------------------
;  Radio Shack TRS-80 Model 100
;---------------------------------

IF M100

defc MDM_DEVTYPE  = $F9
defc RAM_DEVTYPE  = $F8


defc DIAL_SPEED  = $F62B

defc FNKPNT      = $F62C
defc PASPNT      = $F62E
defc FNKSWI      = $F62F
defc FNKSTAT     = $F630
defc SCREEN      = $F638
defc CSRX        = $F639
defc CSRY        = $F63A
defc ACTV_X      = $F63B
defc ACTV_Y      = $F63C
defc LABEL_LN    = $F63D
defc NO_SCROLL   = $F63E
defc CSR_STATUS  = $F63F
defc CSR_ROW     = $F640
defc CSR_COL     = $F641
defc ESCCNT      = $F646
defc ESCSAV      = $F647
defc REVERSE     = $F648
defc TXT_WIDTH   = $F649

defc FNK_FLAG    = $F650

defc TXT_ASKBUF  = $F64A

defc GR_X        = $F64E
defc GR_Y        = $F64F
defc EDITMODE    = $F651
defc ERRTRP      = $F652
defc ONGSBF      = $F654
defc ONDATEF     = $F655
defc POWR_FLAG   = $F656
defc PWRINT      = $F657
defc DUPLEX      = $F658
defc ECHO        = $F659
defc RS232LF     = $F65A
defc STAT        = $F65B
defc PIVOTCALL   = $F660
defc _OUT        = $F667
defc OTPORT      = $F668
defc _INP        = $F66A
defc INPORT      = $F66B
defc ENDPRG      = $F66D
defc ERR_CODE    = $F672
defc LPTPOS     = $F674
defc PRTFLG      = $F675
defc CLMLST      = $F676

defc STKTOP      = $F678
defc CURLIN      = $F67A
defc BASTXT      = $F67C
defc VLZADR      = $F67E
defc BUFFER      = $F680
defc INPBFR      = $F681
defc BUFMIN      = $F684
defc KBUF        = $F685

defc EDTVARS     = $F6DF

defc TXT_ERRFLG  = $F6E1	; (EDTVARS+2)
defc TXT_SEL_BEG = $F6E2
defc TXT_SEL_END = $F6E4
defc TXT_BUFLAG  = $F6E6
defc SAVE_CSRX   = $F6E7	; (EDTVARS+8)

defc STRG_ASKBUF = $F71F

defc TXT_ESCADDR = $F765
defc CUR_TXTFILE = $F767
defc ENDBUF      = $F787
defc TTYPOS      = $F788
defc FNKSTR      = $F789
defc FILETYPE    = $F809
defc IPLBBUF     = $F80A
defc PASTE_BUF   = $F88C
;defc PASTE_BUF   = KBUF		; Hack: the NEC target uses KBUF for the PASTE buffer

defc SHFT_PRINT  = $F88A
defc TXT_SAVPTR  = $F88E
defc TXT_COUNT   = $F890
defc TXT_PTR	 = $F892
defc TXT_BUF	 = $F894
defc TXT_EDITING = $F920
defc BASICMODE   = $F921
defc TRM_WIDTH   = $F922

defc SECS        = $F923
defc SECS_2      = $F924
defc MINS        = $F925
defc MINS_2      = $F926
defc HRS         = $F927
defc HRS_2       = $F928
defc DATE        = $F929
defc DATE_2      = $F92A
defc DAY         = $F92B
defc MONTH       = $F92C
defc YEAR        = $F92D
defc YEAR_2      = $F92E

defc CSRITP      = $F92F
defc TIMCN2      = $F930
defc TIMINT      = $F931
defc TMOFLG      = $F932
defc CLOCK_SS1   = $F933
defc CLOCK_SS2   = $F934
defc CLOCK_MM1   = $F935
defc CLOCK_MM2   = $F936
defc CLOCK_HH1   = $F937
defc CLOCK_HH2   = $F938
defc CLOCK_DT1   = $F939
defc CLOCK_DT2   = $F93A
defc CLOCK_DAY   = $F93B
defc ON_DATE     = $F93C
defc ON_TIME_TM  = $F93D

; --------------------------------------------------------------------------
; TRPTBL () - Data table for the interrupt facilities (78 bytes on MSX).
; *_FLG byte meaning (on MSX):
;                  Bit 7-3 - unused
;                  Bit 2   - Interrupt occurred Y/N   1= Yes
;                  Bit 1   - Interrupt STOP  Y/N      1= Yes
;                  Bit 0   - Interrupt OFF Y/N        1= No

defc TRPTBL      = $F944
defc ON_COM_ADDR = $F945
defc ON_COM      = $F945
defc ON_TIME_FLG = $F947
defc ON_TIME     = $F948

defc DIRECTORY   = $F962
defc SCHDIR      = $F98E
defc SUZUKI      = $F99A
defc HAYASHI     = $F9A5
defc EDTDIR      = $F9B0
defc USRDIR      = $F9BA
defc END_DIR     = $FA81

defc DIRPNT      = $FA8C
defc CASPRV      = $FA8E
defc COMPRV      = $FA8F
defc RAMPRV      = $FA91

defc PASPRV      = $FAA1
defc RAMFILE     = $FAA2
defc OPTROM_SIG  = $FAA4
defc LPRINT_CH   = $FAAC
defc LBL_LINE    = $FAAD
defc PORT_A8     = $FAAE
defc IPL_FNAME   = $FAAF
defc LBLIST      = $FABA
defc LBEDIT      = $FABC
defc STAKSV      = $FABE
defc RAM         = $FAC0

defc CAPTUR      = $FAC2
defc SV_TXTPOS   = $FAC4
defc FNAME_END   = $FAC6
defc CRTFLG      = $FAC7
defc MENU_FLG    = $FAC8
defc RST38_OFFS  = $FAC9
defc SV_CSRY     = $FACA
defc BLINK       = $FACB
defc SV_LABEL_LN = $FACC
defc LPT_FLAG    = $FACD
defc TOP         = $FACE
defc PRLEN       = $FAD0
defc EXE         = $FAD2
defc RAM_FILES   = $FAD8


defc RST38_VECT    = $FADA	; -----  HOOK CODE VECTOR (NEC equivalent listed) -----

defc HCRTPUT       = RST38_VECT+HC_CRTPUT ; 


defc TEXT_END    = $FB62
;
; IN GETTING A POINTER TO A VARIABLE IT IS IMPORTANT TO REMEMBER WHETHER IT
; IS BEING DONE FOR "DIM" OR NOT DIMFLG AND VALTYP MUST BE CONSECUTIVE LOCATIONS
;
defc DIMFLG      = $FB64
defc VALTYP      = $FB65      ; (word) type indicator  (IN THE 8K 0=NUMERIC 1=STRING)
defc OPRTYP      = $FB66      ; Also used as "DORES" by the (de)tokenizer
defc MEMSIZ      = $FB67      ; Highest location in memory used by BASIC
defc TEMPPT      = $FB69      ; (word), start of free area of temporary descriptor
defc TEMPST      = $FB6B      ; Temporary descriptors
defc VARIABLES   = $FB79      ; Storage area for BASIC variables
defc DSCTMP      = $FB89      ; String descriptor which is the result of string fun
defc TMPSTR      = $FB8A      ; Temporary string
defc FRETOP      = $FB8C      ; Starting address of unused area of string area

defc TEMP8       = $FB90      ; Used for garbage collection
defc ENDFOR      = $FB92      ; NEXT address of FOR statement
defc DATLIN      = $FB94      ; Line number of DATA st.read by READ st.
defc SUBFLG      = $FB96      ; (byte), flag for USR fn. array
defc AUTFLG      = $FB97
defc FLGINP      = $FB98      ; Flag for INPUT or READ
defc TEMP        = $FB99      ; (word) temp. reservation for st.code
defc TEMP3       = $FB8E

defc SAVTXT      = $FB9B      ; PTR to recent or running line (e.g. used by RESUME)
defc SAVSTK      = $FB9D      ; Save stack when error occurs
defc ERRLIN      = $FB9F      ; Line where last error occurred
defc DOT         = $FBA1      ; Current line for edit & list
defc ERRTXT      = $FBA3      ; Error messages text table
defc ONELIN      = $FBA5      ; ON ERROR line
defc ONEFLG      = $FBA7      ; ON ERROR status flag
defc NXTOPR      = $FBA8      ; a.k.a. TEMP2, Address ptr to next operator, used by EVAL
defc OLDLIN      = $FBAA      ; old line number set up ^C ...
defc OLDTXT      = $FBAC      ; Points st. to be executed next
defc DO_FILES    = $FBAE
defc CO_FILES    = $FBB0
defc VARTAB      = $FBB2      ; BASIC program end ptr (a.k.a. PROGND, Simple Variables)
defc VAREND      = $FBB4      ; End of variables (aka ARYTAB), begin of array aariables
defc STREND      = $FBB6      ; End of arrays (a.k.a. ARREND lowest free mem)
defc DATPTR      = $FBB8      ; Pointer used by READ to get DATA stored in BASIC PGM
defc DEFTBL      = $FBBA      ; Default valtype for each letter (26 bytes)
defc PRMSTK      = $FBD4      ; (word), previous block definition on stack
defc PRMLEN      = $FBD6      ; (word), number of bytes of obj table
; PARM1
defc PRMPRV      = $FBD9      ; Pointer to previous parameter block
defc PRMLN2      = $FBDB      ; (word), size of parameter block
; PARM2
defc ARYTA2      = $FBDF      ; End point of search
defc PRMFLG      = $FBE0      ; Flag to indicate whether PARM1 was searching
defc NOFUNS      = $FBE1      ; (byte), 0 if no function active
defc TEMP9       = $FBE2      ; Location of temporary storage for garbage collection
defc FUNACT      = $FBE4      ; (word), active functions counter
defc VLZDAT      = $FBE6

defc FBUFFR      = $FBE7
defc NUMSTR      = $FBE8
defc DECTMP      = $FC12
defc DECTM2      = $FC14
defc DECCNT      = $FC16
defc FACCU       = $FC18
defc FACLOW      = $FC1A
defc HOLD8       = $FC28  ; (48 bytes) Double precision operations work area
defc HOLD2       = $FC58  ; (8 bytes)
defc HOLD        = $FC60  ; (9 bytes)
defc ARG         = $FC69
defc ARG_INT     = $FC6B
defc RNDX        = $FC79
defc SEEDRD      = $FC7A

defc MAXFIL      = $FC82
defc FILTAB      = $FC83
defc PTRFIL      = $FC8C
defc FILFLG      = $FC92
defc FILNAM      = $FC93
defc FILNM2      = $FC9C
defc NLONLY      = $FCA7

defc ALT_LCD     = $FCC0

defc MENUVARS    = $FDD7
defc SV_SCREEN   = $FDFA


defc BEGLCD      = $FE00
defc ENDLCD      = $FF40
defc XONXOFF     = $FF41
defc XONXOFF_FLG = $FF42
defc RS232_FLG   = $FF43
defc SOUND_FLG   = $FF44
defc ROMSEL      = $FF45
defc RS232_BUF   = $FF46
defc RS232_COUNT = $FF86
defc CTRL_S_FLG  = $FF8A
defc RS232_BAUD  = $FF8B
defc COMMSK      = $FF8D
defc CASS_HILO   = $FF8E
defc KBSITP      = $FF8F
;defc KB_FLAGS    = $FF97
;defc KB_FNK      = $FF98
defc REPCNT      = $FF90
defc KYDATA      = $FF91
; 
defc KB_SHIFT    = $FFA2
defc KYHOW       = $FFA3
defc KYREPT      = $FFA4
defc KYWHAT      = $FFA5
defc KYBCNT      = $FFAA
defc KYRDBF      = $FFAB
defc BRKCHR      = $FFEB
defc SHAPE       = $FFEC
defc CSRSTS      = $FFF2
defc CSRCNT      = $FFF3
defc LCD_ADDR    = $FFF4
defc GFX_TEMP    = $FFF6
defc SAVSP       = $FFF8
defc IOFLAGS     = $FFFA


; Hook Code (byte offset) values

defc HC_CLEAR   = 00
defc HC_MAXRAM  = 02
defc HC_CHGE    = 04
defc HC_CHSNS   = 06
defc HC_OUTD    = 08
defc HC_LPTO    = 10
defc HC_SETF    = 12
defc HC_INDSKC  = 14
defc HC_RSLF    = 16
defc HC_BAKU    = 18
defc HC_NTFL    = 20
defc HC_SAVE    = 22
defc HC_NOFO    = 24
defc HC_MERG    = 26
defc HC_NULO    = 28
defc HC_GETP    = 30
defc HC_FILOU   = 32
defc HC_BINS    = 34
defc HC_BINL    = 36
defc HC_EOF     = 38
defc HC_PARD    = 40
defc HC_NODE    = 42
defc HC_DEVNAM  = 44
defc HC_POSD    = 46
defc HC_GEND    = 48

defc HC_TRMF6   = 50
defc HC_TRMF7   = 52
defc HC_UPLD    = 54
defc HC_TEXT    = 56
defc HC_WIDT    = 58

defc HC_CRTPUT  = 60

defc HC_SCRE    = 62
defc HC_TVOPN   = 64
;defc HC_TVCLS     = 66
defc HC_TVOUT   = 68
defc HC_WAOPN   = 70
defc HC_WACLS   = 72
defc HC_WAINP   = 74
defc HC_WABCK   = 76
defc HC_LOF     = 78
defc HC_LOC     = 80
defc HC_FILE    = 82
defc HC_DSKI    = 84
defc HC_DSKO    = 86
defc HC_KILL    = 88
defc HC_NAME    = 90
defc HC_MSAVE   = 92
defc HC_MLOAD   = 94

ENDIF







;---------------------------------
;              CODE
;---------------------------------



  ORG $0000

; Reset
  JP BOOT

MENU_MSG:
  DEFM "MENU"
  DEFB 0

; Check syntax, 1 byte follows to be compared
;
; Used by the routines at LINKER, __FOR, __DEF, __LET, ON_ERROR, __IF, TAB,
; __INPUT, __READ, FDTLP, OPNPAR, VARPTR, NVRFIL, UCASE, DEPINT, __POKE,
; __POWER, __DATE_S, __DAY_S, OUTS_B_CHARS, LINE_GFX, MAX_FN, __SOUND, MOTOR_ON,
; __CALL, __SCREEN, __LCOPY, __NAME, __CSAVE, CSAVEM, __CLOAD, STRING_S,
; LFRGNM, INSTR, __CLEAR, INXD, USING, __OPEN, __MERGE, __SAVE, INPUT_S, L4F2E,
; TEL_SET_STAT, KBDMAP_LCASE and __MAX.
SYNCHR:
  LD A,(HL)
  EX (SP),HL
  CP (HL)
  JP NZ,SN_ERR
  INC HL
  EX (SP),HL

; A=(HL), HL++, skip spaces
;
; Used by the routines at ERRMOR, PROMPT, TOKENIZE, STEP, EXEC, __DEF, DEFCON,
; ATOH_2, ON_ERROR, __RESUME, __IF, __PRINT, TAB, __LINE, __READ, FDTLP, EVAL3,
; OPRND, ERR, ERL, VARPTR, UCASE, FPSINT, FNDNUM, CONINT, __POWER, POWER_CONT,
; TIME_S_FN, DATE_S_FN, DAY_S_FN, __MDM, __KEY, LINE_GFX, CSRLIN, MAX_FN,
; _HIMEM, SOUND_ON, MOTOR_OFF, __CALL, __SCREEN, __LCOPY, __KILL, __CSAVE,
; SAVEM, CSAVEM, __CLOAD, LOADM_RUNM, CLOADM, LDIR_B, PRPARM, STRING_S, __VAL,
; INSTR, _ASCTFP, PUFOUT, __CLEAR, __NEXT, INXD, GETVAR, SCPTLP, USING,
; INKEY_S, GETPTR, __OPEN, _OPEN, __MERGE, __SAVE, __CLOSE, INPUT_S, L4F2E,
; TELCOM_RDY, TEL_STAT, TEL_SET_STAT, TEL_LOGON, TEL_TERM, TEL_UPLD, DWNLDR,
; TEL_BYE, TEXT, TXT_CTL_Y, TXT_CTL_G, LOAD_BA_LBL, KBDMAP_LCASE and BOOT.
CHRGTB:
  JP __CHRGTB


; This entry point is used by the routines at TXT_CTL_Z and TXT_CTL_C.
TXT_CKRANGE:
  EX DE,HL
  LD HL,(EDTVARS+12)
  EX DE,HL

; compare DE and HL (aka DCOMPR)
;
; Used by the routines at BAKSTK, SRCHLP, __FOR, ATOH_2, __GOTO,
; __LET, __LIST, LISPRT, RAM_INPUT, __EOF, __LCOPY, CATALOG, KILLASC, __NAME,
; FINDCO, RESFPT, CLOADM, TSTOPL, TESTR, GSTRDE, INSTR, TSTSTR, _ASCTFP,
; INTEXP, __CLEAR, GETVAR, SCPTLP, BS_ERR, TEL_UPLD, TXT_CTL_E, TXT_CTL_A,
; TXT_CTL_Z, TXT_CTL_C, MCLEAR, TXT_CTL_U, TXT_CTL_N, TXT_CTL_V, GET_TXTEND, BASIC,
; IOINIT, KBDMAP_LCASE, BOOT and __MAX.
CPDEHL:
  LD A,H
  SUB D
  RET NZ
  LD A,L
  SUB E
  RET

; Print a space (screen or printer)
;
; Used by the routine at DSPFNK.
OUT_SPC:
  LD A,' '

; Output char in 'A' to console
;
; Used by the routines at ERRMOR, TAB, __READ, __LIST, LISPRT, __KEY,
; OUTS_B_CHARS, CATALOG, PRS1, __BEEP, HOME, __CLS, ESCA,
; POSIT, _TAB, ESC_L, QINLIN, _INLIN_BRK, _INLIN_BS, _INLIN_TAB, INXD, USING,
; CONSOLE_CRLF, TEL_GET_STAT, TEL_FIND, TEL_LOGON, TEL_DIAL_DGT, TEL_TERM,
; TEL_UPLD, __MENU, PRINT_TEXT, SHOW_TIME, MOVE_TEXT, TXT_CTL_G and TXT_CTL_V.
OUTDO:
  JP _OUTDO
  NOP

; 8085 TRAP interrupt vector.  This non maskable interrupt is generated if the
; CPU does not have enough power to operate.
TRAP:
  JP _TRAP
  NOP

; Test number FAC type (Precision mode, etc..)
;
; Used by the routines at TO, STEP, __PRINT, __READ, EVAL3, EVAL_VARIABLE, UCASE,
; GETWORD, STRING_S, INSTR, __FRE, INVSGN, __TSTSGN, __CINT, __CSNG, __CDBL,
; TSTSTR, __FIX, __INT, _ASCTFP, __NEXT, GETVAR, L4F2E and KBDMAP_LCASE.
GETYPR:
  JP _GETYPR
  NOP

; 8085 RST 5.5 interrupt vector, generated if data is present on the Bar Code
; Reader port. Jumps to BARCODE
RST55:
  DI
  JP BARCODE

; Test number sign, error if string
;
; Used by the routines at STEP, GETWORD, DECMUL, __LOG, __SQR, __RND,
; FCOMP, ICOMP, __FIX, PUFOUT and KBDMAP_LCASE.
TSTSGN:
  JP _TSTSGN
  NOP

; 8085 RST 6.5 interrupt vector (happens when UART input is present), jumps to UART
RST65:
  DI
  JP _UART

; RAM vector table driver.The byte after the call determines the offset index
; for VECT_TBL
;
; Used by the routines at CHGET, CHSNS, LPT_OUT, CRT_CTL, WAND_CTL, __EOF,
; _MAXRAM, __WIDTH, __SCREEN, __KILL, __NAME, SAVEM, LOADM_RUNM, HL_CSNG,
; __CLEAR, OUTC_SUB, GETPTR, SETFIL, __OPEN, _OPEN, CLOSE1, __MERGE, __SAVE,
; __CLOSE, RDBYT, INPUT_S, L4F2E, __LOF, __LOC, __LFILES, __DSKO_S, DSKI_S,
; GET_DEVICE, TELCOM_RDY, TEL_TERM, TEL_UPLD, TXT_ESC, FONT and KBDMAP_LCASE.
RST38H:
  JP _RST38H
  NOP

; 8085 RST 7.5 interrupt vector  (timer).
RST75:
  DI
  JP _RST75

; Extra jump table for functions
FNCTAB_FN:
  DEFW __SGN
  DEFW __INT
  DEFW __ABS
  DEFW __FRE
  DEFW __INP
  DEFW __LPOS
  DEFW __POS
  DEFW __SQR
  DEFW __RND
  DEFW __LOG
  DEFW __EXP
  DEFW __COS
  DEFW __SIN
  DEFW __TAN
  DEFW __ATN
  DEFW __PEEK
  DEFW __EOF
  DEFW __LOC
  DEFW __LOF
  DEFW __CINT
  DEFW __CSNG
  DEFW __CDBL
  DEFW __FIX
  DEFW __LEN
  DEFW __STR_S
  DEFW __VAL
  DEFW __ASC
  DEFW __CHR_S
  DEFW __SPACE_S
  DEFW __LEFT_S
  DEFW __RIGHT_S
  DEFW __MID_S
  
; Token table at $80
WORDS:
  DEFB $C5
  DEFM "ND"
  DEFB $C6
  DEFM "OR"
  DEFB $CE
  DEFM "EXT"
  DEFB $C4
  DEFM "ATA"
  DEFB $C9
  DEFM "NPUT"
  DEFB $C4
  DEFM "IM"
  DEFB $D2
  DEFM "EAD"
  DEFB $CC
  DEFM "ET"
  DEFB $C7
  DEFM "OTO"
  DEFB $D2
  DEFM "UN"
  DEFB $C9
  DEFM "F"
  DEFB $D2
  DEFM "ESTORE"
  DEFB $C7
  DEFM "OSUB"
  DEFB $D2
  DEFM "ETURN"
  DEFB $D2
  DEFM "EM"
  DEFB $D3
  DEFM "TOP"
  DEFB $D7
  DEFM "IDTH"
  DEFB $C5
  DEFM "LSE"
  DEFB $CC
  DEFM "INE"
  DEFB $C5
  DEFM "DIT"
  DEFB $C5
  DEFM "RROR"
  DEFB $D2
  DEFM "ESUME"
  DEFB $CF
  DEFM "UT"
  DEFB $CF
  DEFM "N"
  DEFB $C4
  DEFM "SKO$"
  DEFB $CF
  DEFM "PEN"
  DEFB $C3
  DEFM "LOSE"
  DEFB $CC
  DEFM "OAD"
  DEFB $CD
  DEFM "ERGE"
  DEFB $C6
  DEFM "ILES"
  DEFB $D3
  DEFM "AVE"
  DEFB $CC
  DEFM "FILES"
  DEFB $CC
  DEFM "PRINT"
  DEFB $C4
  DEFM "EF"
  DEFB $D0
  DEFM "OKE"
  DEFB $D0
  DEFM "RINT"
  DEFB $C3
  DEFM "ONT"
  DEFB $CC
  DEFM "IST"
  DEFB $CC
  DEFM "LIST"
  DEFB $C3
  DEFM "LEAR"
  DEFB $C3
  DEFM "LOAD"
  DEFB $C3
  DEFM "SAVE"
  DEFB $D4
  DEFM "IME$"
  DEFB $C4
  DEFM "ATE$"
  DEFB $C4
  DEFM "AY$"
  DEFB $C3
  DEFM "OM"
  DEFB $CD
  DEFM "DM"
  DEFB $CB
  DEFM "EY"
  DEFB $C3
  DEFM "LS"
  DEFB $C2
  DEFM "EEP"
  DEFB $D3
  DEFM "OUND"
  DEFB $CC
  DEFM "COPY"
  DEFB $D0
  DEFM "SET"
  DEFB $D0
  DEFM "RESET"
  DEFB $CD
  DEFM "OTOR"
  DEFB $CD
  DEFM "AX"
  DEFB $D0
  DEFM "OWER"
  DEFB $C3
  DEFM "ALL"
  DEFB $CD
  DEFM "ENU"
  DEFB $C9
  DEFM "PL"
  DEFB $CE
  DEFM "AME"
  DEFB $CB
  DEFM "ILL"
  DEFB $D3
  DEFM "CREEN"
  DEFB $CE
  DEFM "EW"
  
FNTAB:
  DEFB $D4
  DEFM "AB("
  DEFB $D4
  DEFM "O"
  DEFB $D5
  DEFM "SING"
  DEFB $D6
  DEFM "ARPTR"
  DEFB $C5
  DEFM "RL"
  DEFB $C5
  DEFM "RR"
  DEFB $D3
  DEFM "TRING$"
  DEFB $C9
  DEFM "NSTR"
  DEFB $C4
  DEFM "SKI$"
  DEFB $C9
  DEFM "NKEY$"
  DEFB $C3
  DEFM "SRLIN"
  DEFB $CF
  DEFM "FF"
  DEFB $C8
  DEFM "IMEM"
  DEFB $D4
  DEFM "HEN"
  DEFB $CE
  DEFM "OT"
  DEFB $D3
  DEFM "TEP"
  DEFB $AB
  DEFB $AD
  DEFB $AA
  DEFB $AF
  DEFB $DE
  DEFB $C1
  DEFM "ND"
  DEFB $CF
  DEFM "R"
  DEFB $D8
  DEFM "OR"
  DEFB $C5
  DEFM "QV"
  DEFB $C9
  DEFM "MP"
  DEFB $CD
  DEFM "OD"
  DEFB $DC
  DEFB $BE
  DEFB $BD
  DEFB $BC
  
KWDTAB:
  DEFB $D3
  DEFM "GN"
  DEFB $C9
  DEFM "NT"
  DEFB $C1
  DEFM "BS"
  DEFB $C6
  DEFM "RE"
  DEFB $C9
  DEFM "NP"
  DEFB $CC
  DEFM "POS"
  DEFB $D0
  DEFM "OS"
  DEFB $D3
  DEFM "QR"
  DEFB $D2
  DEFM "ND"
  DEFB $CC
  DEFM "OG"
  DEFB $C5
  DEFM "XP"
  DEFB $C3
  DEFM "OS"
  DEFB $D3
  DEFM "IN"
  DEFB $D4
  DEFM "AN"
  DEFB $C1
  DEFM "TN"
  DEFB $D0
  DEFM "EEK"
  DEFB $C5
  DEFM "OF"
  DEFB $CC
  DEFM "OC"
  DEFB $CC
  DEFM "OF"
  DEFB $C3
  DEFM "INT"
  DEFB $C3
  DEFM "SNG"
  DEFB $C3
  DEFM "DBL"
  DEFB $C6
  DEFM "IX"
  DEFB $CC
  DEFM "EN"
  DEFB $D3
  DEFM "TR$"
  DEFB $D6
  DEFM "AL"
  DEFB $C1
  DEFM "SC"
  DEFB $C3
  DEFM "HR$"
  DEFB $D3
  DEFM "PACE$"
  DEFB $CC
  DEFM "EFT$"
  DEFB $D2
  DEFM "IGHT$"
  DEFB $CD
  DEFM "ID$"
  DEFB $A7
  DEFB $80

; Jump table for statements and functions
FNCTAB:
  DEFW __END
  DEFW __FOR
  DEFW __NEXT
  DEFW __DATA
  DEFW __INPUT
  DEFW __DIM
  DEFW __READ
  DEFW __LET
  DEFW __GOTO
  DEFW __RUN
  DEFW __IF
  DEFW __RESTORE
  DEFW __GOSUB
  DEFW __RETURN
  DEFW __REM		; REM
  DEFW __STOP
  DEFW __WIDTH
  DEFW __REM		; ELSE
  DEFW __LINE
  DEFW __EDIT
  DEFW __ERROR
  DEFW __RESUME
  DEFW __OUT
  DEFW __ON
  DEFW __DSKO_S
  DEFW __OPEN
  DEFW __CLOSE
  DEFW __LOAD
  DEFW __MERGE
  DEFW __FILES
  DEFW __SAVE
  DEFW __LFILES
  DEFW __LPRINT
  DEFW __DEF
  DEFW __POKE
  DEFW __PRINT
  DEFW __CONT
  DEFW __LIST
  DEFW __LLIST
  DEFW __CLEAR
  DEFW __CLOAD
  DEFW __CSAVE
  DEFW __TIME_S
  DEFW __DATE_S
  DEFW __DAY_S
  DEFW __MDM
  DEFW __MDM
  DEFW __KEY
  DEFW __CLS
  DEFW __BEEP
  DEFW __SOUND
  DEFW __LCOPY
  DEFW __PSET
  DEFW __PRESET
  DEFW __MOTOR
  DEFW __MAX
  DEFW __POWER
  DEFW __CALL
  DEFW __MENU
  DEFW __IPL
  DEFW __NAME
  DEFW __KILL
  DEFW __SCREEN
  DEFW __NEW


; Data block at 738
; ARITHMETIC PRECEDENCE TABLE
PRITAB:
  DEFB $79  ; +   (Token code $F1)
  DEFB $79  ; -
  DEFB $7c  ; *
  DEFB $7c  ; /
  DEFB $7f  ; ^
  DEFB $50  ; AND 
  DEFB $46  ; OR
  DEFB $3c  ; XOR
  DEFB $32  ; EQU
  DEFB $28  ; IMP
  DEFB $7a  ; MOD
  DEFB $7b  ; \   (Token code $FC)


; USED BY ASSIGNMENT CODE TO FORCE THE RIGHT HAND VALUE TO CORRESPOND
; TO THE VALUE TYPE OF THE VARIABLE BEING ASSIGNED TO.

; NUMBER TYPES
TYPE_OPR:
  DEFW __CDBL
  DEFW $0000
  DEFW __CINT
  DEFW TSTSTR
  DEFW __CSNG


;
; THESE TABLES ARE USED AFTER THE DECISION HAS BEEN MADE
; TO APPLY AN OPERATOR AND ALL THE NECESSARY CONVERSION HAS
; BEEN DONE TO MATCH THE TWO ARGUMENT TYPES (APPLOP)
;

; $02F8
; ARITHMETIC OPERATIONS TABLE
DEC_OPR:
  DEFW DECADD
  DEFW DECSUB
  DEFW DECMUL
  DEFW DECDIV
  DEFW DECEXP
  DEFW DECCOMP

defc OPCNT = ((FLT_OPR-DEC_OPR)/2)-1

;$0304
FLT_OPR:
  DEFW FADD
  DEFW FSUB
  DEFW FMULT_BCDE
  DEFW FDIV
  DEFW FEXP
  DEFW FCOMP

;$0310
INT_OPR:
  DEFW IADD
  DEFW ISUB
  DEFW IMULT
  DEFW IDIV
  DEFW INTEXP
  DEFW ICOMP
  
ERRMSG:
  DEFM "NFSNRGODFCOVOMULBSDD"
  DEFM "/0IDTMOSLSSTCNIONRRW"
  DEFM "UEMOIEBNFFAOEFNMDSFLCF"



; Code portion and system variables to be relocated to MAXRAM
;-----------------------
PIVOT_CODE:
;-----------------------
;$F5F0
  DEFB $4D, $8A, $00
  
  DEFB $00
  DEFW MAXRAM	; $F5F0
  
  RET
  NOP
  NOP
  
  EI
  RET
  NOP

  RET
  NOP
  NOP

  RET
  NOP
  NOP
  
  JP LOW_PWR	;$1431 on M100, $143C on KC85
 
; $F605
;EXTROM_TST:
  LD A,1
  OUT ($E8),a		; Page in the optional ROM
  LD HL,$0040
  LD DE,OPTROM_SIG
EXTROM_TST_0:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  LD A,L
  SUB $48	; Scan the ROM in the ($40..$48) range
  JP NZ,EXTROM_TST_0 - PIVOT_CODE + MAXRAM
  OUT ($E8),A		; Page out the optional ROM
  LD HL,(OPTROM_SIG)
IF M100
  LD DE,$4354	; "TC"
ENDIF  
IF KC85 | M10
  LD DE, $4241	; "AB"
ENDIF
  JP CPDEHL


  DI
  LD A,1
  OUT ($E8),A		; Page in the optional ROM
  RST 0

  DEFW $0100

IF KC85 | M10
  DEFW TELCOM_TBL
  DEFW TEL_F6
  RET
  NOP
  NOP
ENDIF

  DEFW $0000
  DEFW $FFFF
  
  DEFS 9
  
  DEFB 1
  DEFB 1
  
  DEFB 8
  DEFB 40
  
  DEFB 0, 0, 0
  DEFB 1, 1, 1, 1

  DEFB 25
  DEFB 40

  DEFB 0, 0, 0
  DEFB 80
  DEFM "80"
  
  DEFS 11

  DEFB 100
  DEFB $FF

  DEFW $0000
  
IF KC85 | M10
  DEFM "37I1E"
ENDIF

IF M100
  DEFM "M7I1E"
ENDIF
  
  JP $0000

  NOP
  RET
  
  NOP
  RET
  
  OUT (0),A
  RET
  
  IN A,(0)
  RET
  
  LD A,(0)
  
  DEFS 6
  
  DEFW $000E

  DEFW NLONLY+110		; Exact variable name still to be determined  :(

  DEFW $FFFE
  DEFW NLONLY+$0B		; Exact variable name still to be determined  :(
  DEFW $0000

;-----------------------
PIVOT_CODE_END:
;-----------------------
  
  
ERR_MSG:
  DEFM " Error"           ; 'Error' text
  DEFB $00
  
IN_MSG:
  DEFM " in "             ; error messages related text
NULL_STRING:
  DEFB $00
  
OK_MSG:
  DEFM "Ok"               ; 'OK' message for BASIC prompt
  DEFB $0D
  DEFB $0A
  DEFB $00
  
BREAK_MSG:
  DEFM "Break"            ; Text for 'Break' message
  DEFB $00

; $0401: Pop the return address for a NEXT or RETURN off the stack.
;
; Search FOR or GOSUB block on stack (skip 2 words)
; Used by the routines at __RETURN and __NEXT.
BAKSTK:
  LD HL,$0004
  ADD HL,SP
; This entry point is used by the routine at __FOR.
LOKFOR:
  LD A,(HL)         ; Get block ID
  INC HL            ; Point to index address
  CP TK_FOR			; Is it a "FOR" token
  RET NZ            ; No - exit
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH HL
  LD H,B
  LD L,C
  LD A,D
  OR E
  EX DE,HL
  JP Z,INDFND
  EX DE,HL
  RST CPDEHL

INDFND:
  LD BC,22
  POP HL
  RET Z
  ADD HL,BC
  JP LOKFOR

; $0422: Initialize system and go to BASIC ready
;
; Used by the routine at INPUT_S.
BASIC_MAIN:
  LD BC,RESTART
  JP ERESET

; This entry point is used by the routine at NEWSTT.
PRG_END:
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,BASIC_MAIN_1
  LD A,(ONEFLG)
  OR A
  LD E,$13
  JP NZ,ERROR
BASIC_MAIN_1:
  JP _ENDPRG
  JP ERROR

; 'SN err' entry for Input STMT
;
; Used by the routine at __LINE.
; $0440
DATSNR:
  LD HL,(DATLIN)
  LD (CURLIN),HL

; entry for '?SN ERROR'
;
; Used by the routines at SYNCHR, PROMPT, LINKER, NEWSTT, ON_ERROR,
; EVAL3, ID_ERR, __POWER, __DATE_S, __DAY_S, KEY_STMTS, __KILL, OPENDO, CSAVEM,
; __CLOAD, CLOADM, __CLEAR, GETVAR, SCPTLP, USING, _OPEN and __MAX.
SN_ERR:
  LD E,$02

  defb $01	; LD BC,NN
; Generate /0 error (division by zero)
;
; Used by the routines at DECDIV, INT_DIV and INTEXP.
; a.k.a. OERR, DZERR
O_ERR:
  LD E,$0B

  defb $01	; LD BC,NN
; NF error: NEXT without FOR
;
; Used by the routine at __NEXT.
NF_ERR:
  LD E,$01

  defb $01	; LD BC,NN
; DD error: re-DIM not allowed
;
; Used by the routine at SCPTLP.
DD_ERR:
  LD E,$0A

  defb $01	; LD BC,NN
; RW error: RESUME without error condition
;
; Used by the routine at __RESUME.
RW_ERR:
  LD E,$14

  defb $01	; LD BC,NN
; OV error: overflow
;
; Used by the routines at GETWORD, DECADD, DECMUL, DECDIV, __TAN, __EXP,
; __CINT, _ASCTFP, INTEXP and __NEXT.
OV_ERR:
  LD E,$06

  defb $01	; LD BC,NN
; MO error: missing operand
;
; Used by the routine at OPRND.
MO_ERR:
  LD E,$16

  defb $01	; LD BC,NN
; TM error: wrong variable type (type mismatch)
;
; Used by the routines at TO, EVAL3, INVSGN, __TSTSGN, __CINT, __CSNG, __CDBL,
; TSTSTR and __INT.
TM_ERR:
  LD E,$0D

; Generate error, number in E
;
; Used by the routines at BASIC_MAIN, FC_ERR, UL_ERR, __RETURN, __ERROR, FDTLP,
; ID_ERR, IO_ERR, TSTOPL, TESTR, CONCAT, ENFMEM, __CONT, BS_ERR, FL_ERR and __EDIT.
ERROR:
  XOR A
  LD (NLONLY),A
  LD HL,(VLZADR)
  LD A,H
  OR L
  JP Z,ERROR_0
  LD A,(VLZDAT)
  LD (HL),A
  LD HL,$0000
  LD (VLZADR),HL
ERROR_0:
  EI
  LD HL,(ERRTRP)
  PUSH HL
  LD A,H
  OR L
  RET NZ

; Routine at 1147
RETERR:
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  LD A,H
  AND L
  INC A
  JP Z,ERRESM			; JP if in 'DIRECT' (immediate) mode
  LD (DOT),HL

; This entry point is also used by the routine at ON_ERROR.
ERRESM:
  LD BC,ERRMOR

; Restore old stack and runtime pointers and jump to (BC)
;
; Used by the routine at BASIC_MAIN.
ERESET:
  LD HL,(SAVSTK)        ;GET A GOOD STACK BACK
  JP STKERR             ;JUMP INTO STKINI

; Routine at 1171
ERRMOR:
  POP BC                  ;POP OFF FNDFOR STOPPER
  LD A,E                  ;[A]=ERROR NUMBER
  LD C,E                  ;ALSO SAVE IT FOR LATER RESTORE
  LD (ERR_CODE),A         ;SAVE IT SO WE KNOW WHETHER TO CALL "EDIT"
  LD HL,(SAVTXT)          ;GET SAVED TEXT POINTER
  LD (ERRTXT),HL          ;SAVE FOR RESUME.
  EX DE,HL                ;SAVE SAVTXT PTR
  LD HL,(ERRLIN)          ;GET ERROR LINE #
  LD A,H                  ;TEST IF DIRECT LINE
  AND L                   ;SET CC'S
  INC A                   ;SETS ZERO IF DIRECT LINE (65535)
  JP Z,NTMDCN             ;IF DIRECT, DONT MODIFY OLDTXT & OLDLIN
  LD (OLDLIN),HL          ;SET OLDLIN=ERRLIN.
  EX DE,HL                ;GET BACK SAVTXT
  LD (OLDTXT),HL          ;SAVE IN OLDTXT.
  LD HL,(ONELIN)
  LD A,H
  OR L
  EX DE,HL
NTMDCN:
  LD HL,ONEFLG
  JP Z,ERROR_REPORT
  AND (HL)
  JP NZ,ERROR_REPORT
  DEC (HL)
  EX DE,HL
  JP GONE4

; Interactive error handling (print error message and break)
; a.k.a. NOTRAP
ERROR_REPORT:
  XOR A
  LD (HL),A
  LD E,C
  CALL CONSOLE_CRLF
  LD A,E
  CP $3B
  JP NC,UNKNOWN_ERR
  CP $32
  JP NC,NTDER2 		; JP if error code is between $32 and $3A
  CP $17
  JP C,LEPSKP

UNKNOWN_ERR:
  LD A,$30		

; if error code is bigger than $3A then force it to $30-$1B=$15 ("Unprintable error")
NTDER2:
  SUB $1B           ; (DSKERR-NONDSK): FIX OFFSET INTO TABLE OF MESSAGES
  LD E,A            ;SAVE BACK ERROR CODE
LEPSKP:
  LD D,$00
  LD HL,ERRMSG-2
  ADD HL,DE
  ADD HL,DE
  LD A,'?'
  RST OUTDO
  LD A,(HL)
  RST OUTDO
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST OUTDO
  LD HL,ERR_MSG
  PUSH HL
  LD HL,(ERRLIN)
  EX (SP),HL
; This entry point is used by the routine at __END.
ERROR_REPORT_1:
  CALL PRS
  POP HL
  LD A,H
  AND L
  INC A
  CALL NZ,LNUM_MSG

  DEFB $3E  ; "LD A,n" to Mask the next byte

; Vector to BASIC Ready (Ok).  Pops the last address off stack.
;
; Used by the routines at __RETURN, __CSAVE, SAVE_BUFFER, __END and INXD.
RESTART:
  POP BC

; Vector to BASIC Ready (Ok). Jump
;
; Used by the routines at __LIST, __LCOPY, SAVEBA, KILLASC, CSAVEM, __CLOAD and
; BASIC.
READY:
  CALL INIT_OUTPUT
  CALL CLOSE_STREAM
  CALL CONSOLE_CRLF
  LD HL,OK_MSG
  CALL PRS

; This is primarily used inside the BASIC ready routine f a blank or illegal
; line was entered.
;
; Used by the routines at PROMPT and __MERGE.
PROMPT:
  LD HL,$FFFF
  LD (CURLIN),HL		; Set interpreter in 'DIRECT' (immediate) mode
  LD HL,ENDPRG
  LD (SAVTXT),HL
  CALL _INLIN		; Line input, FN keys are supported.
  JP C,PROMPT

; Perform operation in (HL) buffer and return to BASIC ready.
  RST CHRGTB		    ; Get first character             GET THE FIRST
  INC A                 ; Test if end of line             SEE IF 0 SAVING THE CARRY FLAG
  DEC A                 ; Without affecting Carry
  JP Z,PROMPT           ; Nothing entered - Get another        IF SO, A BLANK LINE WAS INPUT
  PUSH AF               ; Save Carry status                    SAVE STATUS INDICATOR FOR 1ST CHARACTER
  CALL ATOH             ; Get line number into DE              READ IN A LINE #
  JP NC,BAKSP
  CALL ISFLIO           ; Tests if I/O to device is taking place
  JP Z,SN_ERR


; BACK UP POINTER AFTER # EATEN
BAKSP:
  DEC HL                ;POINT TO PREVIOUS CHAR
  LD A,(HL)             ;GET THE CHAR
  CP ' '                ;A SPACE?
  JP Z,BAKSP            ;YES, KEEP BACKING UP
  CP $09                ;TAB?
  JP Z,BAKSP            ;YES, BACK UP
  INC HL
  LD A,(HL)
  CP ' '
  CALL Z,INCHL
  PUSH DE
  CALL TOKENIZE
  POP DE
  POP AF
  LD (SAVTXT),HL
  JP NC,EXEC_FILE
  PUSH DE
  PUSH BC
  XOR A
  LD (AUTFLG),A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  OR A
  PUSH AF
  EX DE,HL
  LD (DOT),HL
  EX DE,HL
  CALL SRCHLN           ; Search for line number in DE: GET A POINTER TO THE LINE
  JP C,LINFND           ; Jump if line found: LINE EXISTS, DELETE IT
  POP AF                ;GET FLAG SAYS WHETHER LINE BLANK
  PUSH AF               ;SAVE BACK
  JP Z,UL_ERR			; TRYING TO DELETE NON-EXISTANT LINE,   Err $08 - "Undefined line number"
  OR A                  ;CLEAR FLAG THAT SAYS LINE EXISTS

LINFND:
  PUSH BC                     ; Save address of line in prog
  JP NC,PROMPT_2
  CALL __DELETE_0
  LD A,C
  SUB E
  LD C,A
  LD A,B
  SBC A,D
  LD B,A
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,(RAM_FILES)
  ADD HL,BC
  LD (RAM_FILES),HL
PROMPT_2:
  POP DE
  POP AF
  PUSH DE
  JP Z,FINI                   ;IF NOT DON'T INSERT
  POP DE                      ;GET RID OF START OF LINK FIX
  LD HL,$0000
  LD (ONELIN),HL              ; LINE to go when error
  LD HL,(VARTAB)              ; Get end of program           CURRENT END
  EX (SP),HL                  ; Get length of input line     [H,L]=CHARACTER COUNT. VARTAB ONTO THE STACK
  POP BC                      ; End of program to BC         [B,C]=OLD VARTAB
  PUSH HL                     ;SAVE COUNT OF CHARS TO MOVE
  ADD HL,BC                   ; Find new end
  PUSH HL                     ; Save new end                 SAVE NEW VARTAB
  CALL MOVUP                  ; Make space for line
  POP HL                      ; Restore new end              POP OFF VARTAB
  LD (VARTAB),HL              ; Update end of program pointer
  EX DE,HL                    ; Get line to move up in HL
  LD (HL),H                   ; Save MSB                     FOOL CHEAD WITH NON-ZERO LINK
  POP BC                      ;                              RESTORE COUNT OF CHARS TO MOVE
  POP DE                      ; Get new line number          GET LINE # OFF STACK
  PUSH HL                     ;           SAVE START OF PLACE TO FIX LINKS SO IT DOESN'T THINK
  INC HL                      ;                 THIS LINK IS THE END OF THE PROGRAM
  INC HL
  LD (HL),E                   ; Save LSB of line number      PUT DOWN LINE #
  INC HL
  LD (HL),D                   ; Save MSB of line number
  INC HL                      ; To first byte in line
  LD DE,INPBFR                ; Copy buffer to program       ;MOVE LINE FRM KBUF TO PROGRAM AREA
  PUSH HL
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,(RAM_FILES)
  ADD HL,BC
  LD (RAM_FILES),HL
  POP HL
PROMPT_3:
  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  OR A
  JP NZ,PROMPT_3
FINI:
  POP DE                ;GET START OF LINK FIXING AREA
  CALL CHEAD            ;FIX LINKS
  LD HL,(PTRFIL)		; Save I/O pointer before a possible file redirection (RUN "program")
  LD (NXTOPR),HL        ; Save I/O pointer before a possible file redirection (RUN "program")
  CALL RUN_FST          ;DO CLEAR & SET UP STACK 
  LD HL,(NXTOPR)		; Restore I/O pointer
  LD (PTRFIL),HL
  JP PROMPT

; Update in memory line addresses  if a program has been loaded off tape or
; being edited
;
; Used by the routines at __LCOPY, __CSAVE, __CLOAD, CHKSTK, __MENU and BASIC.
LINKER:
  LD HL,(BASTXT)
  EX DE,HL
;
; CHEAD GOES THROUGH PROGRAM STORAGE AND FIXES
; UP ALL THE LINKS. THE END OF EACH
; LINE IS FOUND BY SEARCHING FOR THE ZERO AT THE END.
; THE DOUBLE ZERO LINK IS USED TO DETECT THE END OF THE PROGRAM
;
; This entry point is used by the routines at PROMPT, KILLASC and RESFPT.
CHEAD:
  LD H,D                 ;[H,L]=[D,E]
  LD L,E
  LD A,(HL)              ;SEE IF END OF CHAIN
  INC HL                 ;BUMP POINTER
  OR (HL)                ;2ND BYTE
  RET Z
  INC HL                 ;FIX H TO START OF TEXT
  INC HL
  INC HL
  XOR A
CZLOOP:
  CP (HL)                ;Check if END OF LINE
  INC HL                 ;MAKE [H,L] POINT AFTER TEXT
  JP NZ,CZLOOP           ;NOT END OF LINE?  Then, loop..
  EX DE,HL               ;SWITCH TEMP
  LD (HL),E              ;DO FIRST BYTE OF FIXUP
  INC HL                 ;ADVANCE POINTER
  LD (HL),D              ;2ND BYTE OF FIXUP
  JP CHEAD               ;KEEP CHAINING TIL DONE

; Line number range
;
; SCNLIN SCANS A LINE RANGE OF
; THE FORM  #-# OR # OR #- OR -# OR BLANK
; AND THEN FINDS THE FIRST LINE IN THE RANGE
;
; This entry point is used by the routine at __LIST.
LNUM_RANGE:
  LD DE,$0000            ;ASSUME START LIST AT ZERO
  PUSH DE                ;SAVE INITIAL ASSUMPTION
  JP Z,ALL_LIST          ;IF FINISHED, LIST IT ALL
  POP DE                 ;WE ARE GOING TO GRAB A #
  CALL LNUM_PARM         ;GET A LINE #. IF NONE, RETURNS ZERO
  PUSH DE                ;SAVE FIRST
  JP Z,SNGLIN            ;IF ONLY # THEN DONE.
  RST SYNCHR
  DEFB TK_MINUS          ;MUST BE A DASH.
  
ALL_LIST:
  LD DE,65530            ;ASSUME MAX END OF RANGE
  CALL NZ,LNUM_PARM      ;GET THE END OF RANGE
  JP NZ,SN_ERR           ;MUST BE TERMINATOR
SNGLIN:
  EX DE,HL               ;[H,L] = FINAL
  POP DE                 ;GET INITIAL IN [D,E]

; Push HL and find line # DE
;
; Used by the routine at ON_ERROR.
FNDLN1:
  EX (SP),HL             ;PUT MAX ON STACK, RETURN ADDR TO [H,L]
  PUSH HL                ;SAVE RETURN ADDRESS BACK


;
; FNDLIN SEARCHES THE PROGRAM TEXT FOR THE LINE
; WHOSE LINE # IS PASSED IN [D,E]. [D,E] IS PRESERVED.
; THERE ARE THREE POSSIBLE RETURNS:
;
;	1) ZERO FLAG SET. CARRY NOT SET.  LINE NOT FOUND.
;	   NO LINE IN PROGRAM GREATER THAN ONE SOUGHT.
;	   [B,C] POINTS TO TWO ZERO BYTES AT END OF PROGRAM.
;	   [H,L]=[B,C]
;
;	2) ZERO, CARRY SET. 
;	   [B,C] POINTS TO THE LINK FIELD IN THE LINE
;	   WHICH IS THE LINE SEARCHED FOR.
;	   [H,L] POINTS TO THE LINK FIELD IN THE NEXT LINE.
;
;	3) NON-ZERO, CARRY NOT SET.
;	   LINE NOT FOUND, [B,C]  POINTS TO LINE IN PROGRAM
;	   GREATER THAN ONE SEARCHED FOR.
;	   [H,L] POINTS TO THE LINK FIELD IN THE NEXT LINE.
;

; (Find line # in DE, BC=line addr, HL=next line addr)
;
; Used by the routines at PROMPT, __GOTO and __RESTORE.
SRCHLN:
  LD HL,(BASTXT)       ; Start of program text

; as above but start at the address in HL instead at the start of the BASIC
; program
;
; Used by the routine at __GOTO.
SRCHLP:
  LD B,H               ; BC = Address to look at     IF EXITING BECAUSE OF END OF PROGRAM,
  LD C,L               ;                             SET [B,C] TO POINT TO DOUBLE ZEROES.
  LD A,(HL)            ; Get address of next line
  INC HL               
  OR (HL)              ; End of program found?
  DEC HL               ;GO BACK
  RET Z                ; Yes - Line not found
  INC HL               ;SKIP PAST AND GET THE LINE #
  INC HL               
  LD A,(HL)            ; Get LSB of line number      INTO [H,L] FOR COMPARISON WITH
  INC HL               ;                             THE LINE # BEING SEARCHED FOR
  LD H,(HL)            ; Get MSB of line number      WHICH IS IN [D,E]
  LD L,A               
  RST CPDEHL           ; Compare with line in DE         SEE IF IT MATCHES OR IF WE'VE GONE TOO FAR
  LD H,B               ; HL = Start of this line         MAKE [H,L] POINT TO THE START OF THE
  LD L,C               ;                                 LINE BEYOND THIS ONE, BY PICKING
  LD A,(HL)            ; Get LSB of next line address    UP THE LINK THAT [B,C] POINTS AT
  INC HL               
  LD H,(HL)            ; Get MSB of next line address
  LD L,A               ; Next line to HL
  CCF                  
  RET Z                ; Lines found - Exit
  CCF                  
  RET NC               ; Line not found,at line after    NO MATCH RETURN (GREATER)
  JP SRCHLP            ; Keep looking


; TOKENIZE (CRUNCH)
; ALL "RESERVED" WORDS ARE TRANSLATED INTO SINGLE ONE OR TWO
; (IF TWO, FIRST IS ALWAYS $FF, 377 OCTAL) BYTES WITH THE MSB ON.
; THIS SAVES SPACE AND TIME BY ALLOWING FOR TABLE DISPATCH DURING EXECUTION.
; THEREFORE ALL STATEMENTS APPEAR TOGETHER IN THE RESERVED WORD LIST 
; IN THE SAME ORDER THEY APPEAR IN IN STMDSP.
;
; NUMERIC CONSTANTS ARE ALSO CONVERTED TO THEIR INTERNAL 
; BINARY REPRESENTATION TO IMPROVE EXECUTION SPEED
; LINE NUMBERS ARE ALSO PRECEEDED BY A SPECIAL TOKEN SO THAT
; LINE NUMBERS CAN BE CONVERTED TO POINTERS AT EXECUTION TIME.
;
; Token compression routine
; Used by the routine at PROMPT.
TOKENIZE:
  XOR A
  LD (OPRTYP),A      ; other targets use DORES:  Indicates whether stored word can be crunched
  LD C,A
  LD DE,INPBFR
CRNCLP:
  LD A,(HL)
  CP ' '             ; Is it a space?
  JP Z,MOVDIR        ; Yes - Copy direct
  LD B,A
  CP '"'             ; Is it a quote?
  JP Z,CPYLIT        ; Yes - Copy literal string
  OR A
  JP Z,CRDONE
  INC HL
  OR A
  JP M,CRNCLP
  DEC HL
  LD A,(OPRTYP)		    ; other targets use DORES:  Indicates whether stored word can be crunched
  OR A                  ; Literal?
  LD A,(HL)             ; Get byte to copy
  JP NZ,MOVDIR          ; Literal - Copy direct
  CP '?'                ; Is it "?" short for PRINT           ; Is it "?" short for PRINT
  LD A,TK_PRINT		    ; "PRINT" token                       ; TK_PRINT: "PRINT" token
  JP Z,MOVDIR           ; Yes - replace it                    ;THEN USE A "PRINT" TOKEN
  LD A,(HL)             ; Get byte again
  CP '0'                ; Is it less than "0"
  JP C,FNDWRD           ; Yes - Look for reserved words
  CP '<'                ; Is it "0123456789:;" ?
  JP C,MOVDIR           ; Yes - copy it direct
FNDWRD:
  PUSH DE               ; Look for reserved words
  LD DE,WORDS-1         ; Point to table                      ;GET POINTER TO ALPHA DISPATCH TABLE
  PUSH BC               ; Save count
  LD BC,RETNAD          ; Where to return to
  PUSH BC               ; Save return address
  LD B,TK_END-1         ; First token value -1
  LD A,(HL)             ; Get byte
  CP 'a'                ; Less than "a" ?
  JP C,SEARCH           ; Yes - search for words
  CP 'z'+1              ; Greater than "z" ?
  JP NC,SEARCH          ; Yes - search for words
  AND $5F	 			; convert to uppercase
  LD (HL),A
SEARCH:
  LD C,(HL)             ; Search for a word
  EX DE,HL
GETNXT:
  INC HL                ; Get next reserved word
  OR (HL)               ; Start of word?
  JP P,GETNXT      		; No - move on
  INC B                 ; Increment token value
  LD A,(HL)             ; Get byte from table
  AND $7F         		; Strip bit 7
  RET Z                 ; Return if end of list
  CP C                  ; Same character as in buffer?
  JP NZ,GETNXT          ; No - get next word
  EX DE,HL
  PUSH HL               ; Save start of word
NXTBYT:
  INC DE                ; Look through rest of word
  LD A,(DE)             ; Get byte from table                       ;GET BYTE FROM RESERVED WORD LIST   (Get byte from table)
  OR A                  ; End of word ?                             ;GET RID OF HIGH BIT
  JP M,MATCH            ; Yes - Match found                         ;IF=0 THEN END OF THIS CHARS RESLT  (JP if end of list)
  LD C,A                ; Save it
  LD A,B                ; Get token value
  CP TK_GOTO            ; Is it "GOTO" token ?
  JP NZ,NOSPC    	  	; No - Don't allow spaces
  RST CHRGTB			; Gets next character (or token) from BASIC text.
  DEC HL                ; Cancel increment from GETCHR
NOSPC:
  INC HL                ; Next byte
  LD A,(HL)             ; Get byte
  CP 'a'                ; Less than "a" ?
  JP C,NOCHNG           ; Yes - don't change
  AND $5F               ; 01011111, Make upper case
NOCHNG:
  CP C                  ; Same as in buffer ?
  JP Z,NXTBYT           ; Yes - keep testing
  POP HL                ; Get back start of word
  JP SEARCH             ; Look at next word
  
MATCH:
  LD C,B               ; Word found - Save token value
  POP AF               ; Throw away return
  EX DE,HL             
  RET                  ; Return to "RETNAD"

; Routine at 1741
RETNAD:
  EX DE,HL             ; Get address in string
  LD A,C               ; Get token value
  POP BC               ; Restore buffer length
  POP DE               ; Get destination address
  EX DE,HL
  CP TK_ELSE           ;HAVE TO PUT A HIDDEN COLON IN FRONT OF "ELSE"S
  LD (HL),':'
  JP NZ,TOKENIZE_8
  INC C                ;Advance ptr in crunch buffer only if we got TK_ELSE
  INC HL
TOKENIZE_8:
  CP TK_APOSTROPHE     ;SINGLE QUOTE TOKEN?   "'" = comment (=REM)
  JP NZ,NTSNGT
  LD (HL),':'          ;SAVE ":" IN CRUNCH BUFFER
  INC HL
  LD B,TK_REM          ;STORE ":$REM" IN FRONT FOR EXECUTION
  LD (HL),B            ;SAVE IT
  INC HL
  INC C
  INC C
NTSNGT:
  EX DE,HL
MOVDIR:
  INC HL            ; Next source in buffer
  LD (DE),A         ; Put byte in buffer
  INC DE            ; Move up buffer
  INC C             ; Increment length of buffer
  SUB ':'           ; ":", End of statement?
  JP Z,SETLIT       ; Jump if multi-statement line
  CP TK_DATA-':'    ; .. Is it DATA statement ?
  JP NZ,TSTREM      ; No - see if REM
SETLIT:
  LD (OPRTYP),A		; a.k.a. DORES, Indicates whether stored word can be crunched
TSTREM:
  SUB TK_REM-':'    ;  -> is it TK_REM ?
  JP Z,FNDWRD3	
  SUB $71			; $71 + $8E = $FF
  JP NZ,CRNCLP      ; No - Leave flag
FNDWRD3:
  LD B,A            ; Copy rest of buffer

NXTCHR:             ; (=KLOOP)
  LD A,(HL)         ; Get byte
  OR A				; End of line ?
  JP Z,CRDONE		; Yes - Terminate buffer
  CP B              ; End of statement ?
  JP Z,MOVDIR       ; Yes - Get next one

CPYLIT:
  INC HL            ; Move up source string
  LD (DE),A			; Save in destination buffer
  INC C             ; Increment length
  INC DE            ; Move up destination buffer
  JP NXTCHR         ; Repeat

CRDONE:
  LD HL,$0005
  LD B,H
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,BUFFER       ; Point to start of buffer
  ; Mark end of buffer (A = 00)
  LD (DE),A
  INC DE             
  LD (DE),A
  INC DE             
  LD (DE),A
  RET


; 'FOR' BASIC command
;
; A "FOR" ENTRY ON THE STACK HAS THE FOLLOWING FORMAT:
;
; LOW ADDRESS
;	TOKEN ($FOR IN HIGH BYTE)  1 BYTE
;	A POINTER TO THE LOOP VARIABLE  2 BYTES
;	A BYTE REFLECTING THE SIGN OF THE INCREMENT 1 BYTE
;	THE STEP 4 BYTES
;	THE UPPER VALUE 4 BYTES
;	THE LINE # OF THE "FOR" STATEMENT 2 BYTES
;	A TEXT POINTER INTO THE "FOR" STATEMENT 2 BYTES
;
; 'FOR' BASIC instruction
__FOR:
  LD A,$64               ; Flag "FOR" assignment
  LD (SUBFLG),A          ; Save "FOR" flag                   DONT RECOGNIZE SUBSCRIPTED VARIABLES
  CALL __LET             ; Set up initial index              GET POINTER TO LOOP VARIABLE
  POP BC                 ; Drop RETurn address               GET RID OF THE NEWSTT RETURN
  PUSH HL                ; Save code string address          SAVE THE TEXT POINTER
  CALL __DATA            ; Get next statement address        SET [H,L]=END OF STATEMENT
  LD (ENDFOR),HL         ; Next address of FOR st.	         SAVE FOR COMPARISON
  LD HL,$0002            ; Offset for "FOR" block            SET UP POINTER INTO STACK
  ADD HL,SP              ; Point to it
FORSLP:                  
  CALL LOKFOR            ; Look for existing "FOR" block     MUST HAVE VARIABLE POINTER IN [D,E]
  JP NZ,FORFND           ; IF NO MATCHING ENTRY, DON'T ELIMINATE ANYTHING
  ADD HL,BC              ; IN THE CASE OF "FOR" WE ELIMINATE THE MATCHING ENTRY AS WELL AS EVERYTHING AFTER IT
  PUSH DE                ; SAVE THE TEXT POINTER
  DEC HL                 ; SEE IF END TEXT POINTER OF MATCHING ENTRY
  LD D,(HL)              ; MATCHES THE FOR WE ARE HANDLING
  DEC HL                 ; PICK UP THE END OF THE "FOR" TEXT POINTER
  LD E,(HL)              ; FOR THE ENTRY ON THE STACK
  INC HL                 ; WITHOUT CHANGING [H,L]
  INC HL                 
  PUSH HL                ; Save block address                SAVE THE STACK POINTER FOR THE COMPARISON
  LD HL,(ENDFOR)         ; Get address of loop statement     GET ENDING TEXT POINTER FOR THIS "FOR"
  RST CPDEHL             ; Compare the FOR loops             SEE IF THEY MATCH
  POP HL                 ; Restore block address             GET BACK THE STACK POINTER
  POP DE                 ;                                   GET BACK THE TEXT POINTER
  JP NZ,FORSLP           ; Different FORs - Find another     KEEP SEARCHING IF NO MATCH
  POP DE                 ; Restore code string address       GET BACK THE TEXT POINTER
  LD SP,HL               ; Remove all nested loops           DO THE ELIMINATION
  LD (SAVSTK),HL         ; UPDATE SAVED STACK SINCE A MATCHING ENTRY WAS FOUND
  
  DEFB $0E               ; LD C,N to mask the next byte

; Routine at 1880
;
; Used by the routine at __FOR.
FORFND:
  POP DE                ; Code string address to DE
  EX DE,HL              ; [H,L]=TEXT POINTER
  LD C,12               ; MAKE SURE 24 BYTES ARE AVAILABLE OFF OF THE STACK
  CALL CHKSTK           ; Check for 12 levels of stack
  PUSH HL               ; REALLY SAVE THE TEXT POINTER 
  LD HL,(ENDFOR)        ; Get first statement of loop        PICK UP POINTER AT END OF "FOR" 
                        ;                                    JUST BEYOND THE TERMINATOR
  EX (SP),HL            ; Save and restore code string       PUT [H,L] POINTER TO TERMINATOR ON THE STACK
                        ;                                    AND RESTORE [H,L] AS TEXT POINTER AT VARIABLE NAME
  PUSH HL               ; Re-save code string address        PUSH THE TEXT POINTER ONTO THE STACK
  LD HL,(CURLIN)        ; Get current line number            [H,L] GET THE CURRENT LINE #
  EX (SP),HL            ; Save and restore code string       NOW THE CURRENT LINE # IS ON THE STACK, HL IS THE TEXT POINTER
  RST SYNCHR            ; Make sure "TO" is next
  DEFB TK_TO            ; "TO" token                         "TO" IS NECESSARY
  RST GETYPR            ;                                    SEE WHAT TYPE THIS VALUE HAS
  JP Z,TM_ERR           ; If string type, "Type mismatch"    GIVE STRINGS A "TYPE MISMATCH"
  PUSH AF               ; save type                          SAVE THE INTEGER/FLOATING FLAG
  CALL EVAL             ;                                    EVALUATE THE TARGET VALUE FORMULA
  POP AF                ; Restore type                       POP OFF THE FLAG
  PUSH HL               ; SAVE THE TEXT POINTER
  JP NC,FORFND_DBL      ; Deal with DOUBLE-PRECISION
  JP P,FORFND_SNG       ; POSITIVE MEANS SINGLE PRECISION "FOR"-LOOP
  CALL __CINT           ; COERCE THE FINAL VALUE
  EX (SP),HL            ; SAVE IT ON THE STACK AND REGET THE TEXT POINTER

  LD DE,$0001			; Default value for STEP               DEFAULT THE STEP TO BE 1
  LD A,(HL)             ; Get next byte in code string         SEE WHAT CHARACTER IS NEXT
  CP TK_STEP            ; See if "STEP" is stated              IS THERE A "STEP" CLAUSE?
  CALL Z,FPSINT         ; If so, get updated value for 'STEP'  IF SO, READ THE STEP INTO [D,E]
  PUSH DE               ;                                      PUT THE STEP ONTO THE STACK
  PUSH HL               ;                                      SAVE THE TEXT POINTER
  EX DE,HL              ;                                      STEP INTO [H,L]
  CALL __TSTSGN_0		; Test sign for 'STEP'                 THE SIGN OF THE STEP INTO [A]
  JP FORFND_1           ;                                      FINISH UP THE ENTRY BY PUTTING THE SIGN OF
                        ;                                      THE STEP AND THE DUMMY ENTRIES ON THE STACK

; This entry point is used by the routine at TO.
FORFND_DBL:
  CALL __CDBL
  POP DE
  LD HL,$FFF8		; -8
  ADD HL,SP
  LD SP,HL
  PUSH DE
  CALL FP_DE2HL
  POP HL
  LD A,(HL)
  CP TK_STEP		; token code for 'STEP'
  LD DE,FP_UNITY
  LD A,$01
  JP NZ,STEP_1
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL EVAL
  PUSH HL
  CALL __CDBL
  RST TSTSGN
  LD DE,FACCU
  POP HL
  
STEP_1:
  LD B,H
  LD C,L
  LD HL,$FFF8		; -8
  ADD HL,SP
  LD SP,HL
  PUSH AF
  PUSH BC
  CALL FP2HL
  POP HL
  POP AF
  JP STEP_5

; This entry point is used by the routine at TO.
FORFND_SNG:
  CALL __CSNG           ; Get value for 'TO'
  CALL BCDEFP           ; Move "TO" value to BCDE
  POP HL                ; Restore code string address
  PUSH BC               ; Save "TO" value in block
  PUSH DE               ; SAVE THE SIGN OF THE INCREMENT
  LD BC,$1041			; BCDE = 1.0 float (default value for STEP)
  LD DE,$0000
  LD A,(HL)
  CP TK_STEP			; See if "STEP" is stated
  LD A,$01              ; Sign of step = 1
  JP NZ,SAVSTP_2        ; No STEP given - Default to 1
  CALL EVAL_0           ; Jump over "STEP" token and point to step value
  PUSH HL               ; Save code string address
  CALL __CSNG           ; Get value for 'STEP'
  CALL BCDEFP           ; Move STEP to BCDE
  RST TSTSGN            ; Test sign for 'STEP' in FPREG
FORFND_1:
  POP HL
SAVSTP_2:                ; Save the STEP value in block
  PUSH DE
  PUSH BC
  PUSH BC
  PUSH BC
  PUSH BC
  PUSH BC
STEP_5:
  OR A
  JP NZ,STEP_6
  LD A,$02
STEP_6:
  LD C,A               ;[C]=SIGN OF STEP
  RST GETYPR           ;MUST PUT ON INTEGER/SINGLE-PRECISION FLAG - MINUS IS SET FOR INTEGER CASE
  LD B,A               ;HIGH BYTE = INTEGER/SINGLE PRECISION FLAG
  PUSH BC              ;SAVE FLAG AND SIGN OF STEP BOTH
  PUSH HL              ; Save code string address
  LD HL,(TEMP)         ; Get address of index variable       ;GET THE POINTER TO THE VARIABLE BACK
  EX (SP),HL           ; Save and restore code string        ;PUT THE PTR ON SP AND RESTORE THE TEXT POINTER
; --- Put "FOR" block marker ---
PUTFID:
  LD B,TK_FOR          ; "FOR" block marker                  ;FINISH UP "FOR"
  PUSH BC              ; Save it
  INC SP               ; Don't save C                        ;THE "TOKEN" ONLY TAKES ONE BYTE OF STACK SPACE
;	JMP	NEWSTT		;ALL DONE

;
; BASIC program execution driver (a.k.a. RUNCNT).  HL points to code.
;
; BACK HERE FOR NEW STATEMENT. CHARACTER POINTED TO BY [H,L]
; ":" OR END-OF-LINE. THE ADDRESS OF THIS LOCATION IS
; LEFT ON THE STACK WHEN A STATEMENT IS EXECUTED SO
; IT CAN MERELY DO A RETURN WHEN IT IS DONE.
;
; Used by the routines at __CLOAD, CLOADM, __CLEAR, __NEXT, INXD, __MENU and __MAX.
NEWSTT:
  CALL RCVX
  CALL NZ,CLR_ALLINT_2
  LD A,(ONGSBF)
  OR A
  CALL NZ,EXEC_ONGOSUB
; This entry point is used by the routine at __MDM.
NEWSTT_0:
  CALL ISCNTC		 ; Test break
  LD (SAVTXT),HL	 ; Save code address for break
  EX DE,HL           ;SAVE TEXT POINTER
  LD HL,$0000        ;SAVE STACK POINTER
  ADD HL,SP          ;COPY TO [H,L]
  LD (SAVSTK),HL     ;SAVE IT TO REMEMBER HOW TO RESTART THIS STATEMENT
  EX DE,HL           ;GET CURRENT TEXT POINTER BACK IN [H,L] TO SAVE BYTES & SPEED
  LD A,(HL)          ;GET CURRENT CHARACTER WHICH TERMINATED THE LAST STATEMENT
  CP ':'             ; Multi statement line?
  JP Z,EXEC          ; Yes - Execute it
  OR A               ; End of line?                   ;MUST BE A ZERO
  JP NZ,SN_ERR       ; No - Syntax error
  INC HL             ; Point to address of next line

; This entry point is used by the routines at ERRMOR and UL_ERR.
                     ;CHECK POINTER TO SEE IF IT IS ZERO, IF SO WE ARE AT THE END OF THE PROGRAM
GONE4:
  LD A,(HL)		  	 ; Get LSB of line pointer
  INC HL
  OR (HL)            ; Is it zero (End of prog)?
  JP Z,PRG_END       ; Yes - Terminate execution        ;FIX SYNTAX ERROR IN UNENDED ERROR ROUTINE
  INC HL             ; Point to line number
  LD E,(HL)          ; Get LSB of line number
  INC HL
  LD D,(HL)          ; Get MSB of line number
  EX DE,HL           ; Line number to HL
  LD (CURLIN),HL     ; Save as current line number
  EX DE,HL           ; Line number back to DE

; Start executing a program at the address in HL.
;
; Used by the routines at NEWSTT and INIT_PRINT_h.
EXEC:
  RST CHRGTB		; Get key word                      ;GET THE STATEMENT TYPE
  LD DE,NEWSTT      ; Where to RETurn to                ;PUSH ON A RETURN ADDRESS OF NEWSTT
  PUSH DE           ; Save for RETurn                   ;STATEMENT


;"IF" COMES HERE, "ON ... GOTO" AND "ON ... GOSUB" COME HERE
;(RET Z is skipped on MBASIC and MSX)
; This entry point is used by the routines at __ON and __IF.
ONJMP:
  RET Z				; Go to NEWSTT if end of STMT       ;IF A TERMINATOR TRY AGAIN

; Execute the compressed instruction token in the A register
;
; Used by the routine at ON_ERROR.
STATEMENT:
  SUB TK_END                 ; $81 = TK_END .. is it a token?
  JP C,__LET                 ; No - try to assign it, MUST BE A LET
  CP TK_NEW+1-TK_END         ; NEW to LOCATE ?
  JP NC,NOT_KEYWORD          ; Not a key word - ?SN Error

  ; We're in the token range between TK_END and ..
  RLCA
  LD C,A
  LD B,$00
  EX DE,HL          ; Save code string address
  LD HL,FNCTAB		; Function routine addresses       ;a.k.a. STMDSP: STATEMENT DISPATCH TABLE
  ADD HL,BC         ; Point to right address           ;ADD ON OFFSET 
  LD C,(HL)         ; Get LSB of address               ;PUSH THE ADDRESS TO GO TO ONTO
  INC HL                                               ;THE STACK
  LD B,(HL)         ; Get MSB of address               ;PUSHM SAVES BYTES BUT NOT SPEED
  PUSH BC                                              
  EX DE,HL                                             ;RESTORE THE TEXT POINTER

; Pick next char from program
;
; Used by the routines at CHRGTB, __CHRCKB, LNUM_PARM, __IF, DTSTR, GETPTR,
; __OPEN and __CLOSE.
;
; NEWSTT FALLS INTO CHRGET. THIS FETCHES THE FIRST CHAR AFTER
; THE STATEMENT TOKEN AND THE CHRGET'S "RET" DISPATCHES TO STATEMENT
;
__CHRGTB:
  INC HL                ; Point to next character        ;DUPLICATION OF CHRGET RST FOR SPEED

; Same as RST 10H but with no pre-increment of HL
; Gets current character (or token) from BASIC text.
__CHRCKB:
  LD A,(HL)             ; Get next code string byte      ;SEE CHRGET RST FOR EXPLANATION
  CP ':'                ; Z if ":"
  RET NC                ; NC if > "9"

;
; CHRCON IS THE CONTINUATION OF THE CHRGET RST
;
; IN EXTENDED, CHECK FOR INLINE CONSTANT AND IF ONE
; MOVE IT INTO THE FAC & SET VALTYP APPROPRIATELY
;
  CP ' '                ;                               MUST SKIP SPACES
  JP Z,__CHRGTB         ; Skip over spaces              GET ANOTHER CHARACTER
  CP OCTCON             ; IS IT INLINE CONSTANT ?
  JP NC,NOTCON          ; NO, SHOULD BE TAB OR LF
  CP CONCON             ; ARE WE TRYING TO RE-SCAN A CONSTANT?
  JP NC,__CHRGTB
NOTCON:
  CP '0'
  CCF
  INC A
  DEC A
  RET


;
;SIMPLE-USER-DEFINED-FUNCTION CODE
;
; IN THE 8K VERSION (SEE LATER COMMENT FOR EXTENDED)
; NOTE ONLY SINGLE ARGUMENTS ARE ALLOWED TO FUNCTIONS
; AND FUNCTIONS MUST BE OF THE SINGLE LINE FORM:
; DEF FNA(X)=X^2+X-2
; NO STRINGS CAN BE INVOLVED WITH THESE FUNCTIONS
;
; IDEA: CREATE A FUNNY SIMPLE VARIABLE ENTRY
; WHOSE FIRST CHARACTER (SECOND WORD IN MEMORY)
; HAS THE 200 BIT SET.
; THE VALUE WILL BE:
;
; 	A TXTPTR TO THE FORMULA
;	THE NAME OF THE PARAMETER VARIABLE
;
; FUNCTION NAMES CAN BE LIKE "FNA4"
;

; 'DEF' BASIC instruction
__DEF:
  CP TK_INT
  JP Z,DEFINT
  CP 'D'
  JP NZ,__DEF_0
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR
  DEFB 'B'
  RST SYNCHR
  DEFB 'L'

DEFDBL:
  LD E,$08		; DEFAULT SOME LETTERS TO Double Precision type
  JP DEFCON

DEFINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD E,$02		; DEFAULT SOME LETTERS TO Integer type
  JP DEFCON
  
__DEF_0:
  RST SYNCHR
  DEFB 'S'
  CP 'N'
  JP NZ,__DEF_1	; not 'DEFS..NG', try 'DEFS..TR'

  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR
  DEFB 'G'

DEFSNG:
  LD E,$04		; DEFAULT SOME LETTERS TO Single precision type
  JP DEFCON

__DEF_1:
  RST SYNCHR
  DEFB 'T'
  RST SYNCHR
  DEFB 'R'

DEFSTR:
  LD E,$03		; DEFAULT SOME LETTERS TO String type

; Declare the variables in the buffer pointed to by HL to the type in the E
; register
;
; Used by the routine at __DEF.
DEFCON:
  CALL IS_LETTER        ;MAKE SURE THE ARGUMENT IS A LETTER
  LD BC,SN_ERR          ;PREPARE "SYNTAX ERROR" RETURN
  PUSH BC
  RET C                 ;RETURN IF THERES NO LETTER
  SUB 'A'               ;MAKE AN OFFSET INTO DEFTBL
  LD C,A                ;SAVE THE INITIAL OFFSET
  LD B,A                ;ASSUME IT WILL BE THE FINAL OFFSET
  RST CHRGTB            ;GET THE POSSIBLE DASH
  CP TK_MINUS           ;'-' A RANGE ARGUMENT? ; 
  JP NZ,NOTRNG          ;IF NOT, JUST ONE LETTER
  RST CHRGTB            ;GET THE FINAL POSITION
  CALL IS_LETTER        ;CHECK FOR A LETTER
  RET C                 ;GIVE A SYNTAX ERROR IF IMPROPER
  SUB 'A'               ;MAKE IT AN OFFSET
  LD B,A                ;PUT THE FINAL IN [B]
  RST CHRGTB            ;GET THE TERMINATOR
NOTRNG:
  LD A,B                ;GET THE FINAL CHARACTER
  SUB C                 ;SUBTRACT THE START
  RET C                 ;IF IT'S LESS THATS NONSENSE
  INC A                 ;SETUP THE COUNT RIGHT
  EX (SP),HL            ;SAVE THE TEXT POINTER AND GET RID OF THE "SYNTAX ERROR" RETURN
  LD HL,DEFTBL          ;POINT TO THE TABLE OF DEFAULTS
  LD B,$00              ;SETUP A TWO-BYTE STARTING OFFSET
  ADD HL,BC             ;MAKE [H,L] POINT TO THE FIRST ENTRY TO BE MODIFIED
LPDCHG:
  LD (HL),E             ;MODIFY THE DEFAULT TABLE
  INC HL                
  DEC A                 ;COUNT DOUNT THE NUMBER OF CHANGES TO MAKE
  JP NZ,LPDCHG          
  POP HL                ;GET BACK THE TEXT POINTER
  LD A,(HL)             ;GET LAST CHARACTER
  CP ','                ;IS IT A COMMA?
  RET NZ                ;IF NOT STATEMENT SHOULD HAVE ENDED
  RST CHRGTB            ;OTHERWISE SET UP TO SCAN NEW RANGE
  JP DEFCON

; This entry point is used by the routine at SCPTLP.
;
; INTIDX READS A FORMULA FROM THE CURRENT POSITION AND
; TURNS IT INTO A POSITIVE INTEGER
; LEAVING THE RESULT IN [D,E].  NEGATIVE ARGUMENTS
; ARE NOT ALLOWED. [H,L] POINTS TO THE TERMINATING
; CHARACTER OF THE FORMULA ON RETURN.
;
INTIDX:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
; This entry point is used by the routine at __CLEAR.
INTIDX_0:
  CALL FPSINT_0          ;READ A FORMULA AND GET THE RESULT AS AN INTEGER IN [D,E]
                         ;ALSO SET THE CONDITION CODES BASED ON THE HIGH ORDER OF THE RESULT
  RET P                  ;DON'T ALLOW NEGATIVE NUMBERS

; entry for '?FC ERROR'
;
; Used by the routines at __ERROR, NVRFIL, CONINT, POWER_ON, __IPL, __MDM,
; OUTS_B_CHARS, LINE_GFX, __SOUND, __LCOPY, KILLASC, __NAME, CSAVEM, __CLOAD,
; LOADM_RUNM, CLOADM, PRPARM, __ASC, __MID_S, INSTR, __LOG, __SQR, __CONT,
; __CLEAR, BS_ERR, USING, INPUT_S and __MAX.
FC_ERR:
  LD E,$05				; Err $05 - "Illegal function call"
  JP ERROR              ;TOO BIG. FUNCTION CALL ERROR

; Evaluate line number text pointed to by HL.
;
;
; LINSPC IS THE SAME AS LINGET EXCEPT IN ALLOWS THE
; CURRENT LINE (.) SPECIFIER
;
; Used by the routine at LINKER.
LNUM_PARM:
  LD A,(HL)             ;GET CHAR FROM MEMORY
  CP '.'                ;IS IT CURRENT LINE SPECIFIER
  EX DE,HL              ;SAVE TEXT POINTER
  LD HL,(DOT)           ;GET CURRENT LINE #
  EX DE,HL              ;GET BACK TEXT POINTER
  JP Z,__CHRGTB         ;ALL DONE.


; Get specified line number
; ASCII to Integer, result in DE
;
; LINGET READS A LINE # FROM THE CURRENT TEXT POSITION
;
; LINE NUMBERS RANGE FROM 0 TO 65529
;
; THE ANSWER IS RETURNED IN [D,E].
; [H,L] IS UPDATED TO POINT TO THE TERMINATING CHARACTER
; AND [A] CONTAINS THE TERMINATING CHARACTER WITH CONDITION
; CODES SET UP TO REFLECT ITS VALUE.
;
; Used by the routines at PROMPT, __GOTO, ON_ERROR, __RESUME and __RESTORE.
ATOH:
  DEC HL                ;BACKSPACE PTR

; As above, but conversion starts at HL+1
;
; Used by the routine at ON_ERROR.
ATOH_2:
  LD DE,$0000           ;ZERO ACCUMULATED LINE #
GTLNLP:
  RST CHRGTB
  RET NC                ;WAS IT A DIGIT
  PUSH HL
  PUSH AF
  LD HL,65529/10     ; Largest number 65529         ;SEE IF THE LINE # IS TOO BIG
  RST CPDEHL
  JP C,POPHSR         ; YES, DON'T SCAN ANY MORE DIGITS IF SO.  FORCE CALLER TO SEE DIGIT AND GIVE SYNTAX ERROR
                      ; CAN'T JUST GO TO SYNTAX ERROR BECAUSE OF NON-FAST RENUM WHICH CAN'T TERMINATE
  LD H,D              ;SAVE [D,E]
  LD L,E
  ADD HL,DE		; *2
  ADD HL,HL		; ..*4
  ADD HL,DE     ; ..*5
  ADD HL,HL     ; ..*10  ;PUTTING [D,E]*10 INTO [H,L]
  POP AF        ; Restore digit
  SUB '0'       ; Make it 0 to 9
  LD E,A        ; DE = Value of digit
  LD D,$00
  ADD HL,DE     ; Add to number                   ;ADD THE NEW DIGIT
  EX DE,HL      ; Number to DE
  POP HL        ; Restore code string address     ;GET BACK TEXT POINTER
  JP GTLNLP     ; Go to next character

POPHSR:
  POP AF        ;GET OFF TERMINATING DIGIT
  POP HL        ;GET BACK OLD TEXT POINTER
  RET

; Routine at 2319
__RUN:
  JP Z,RUN_FST       ; RUN from start if just RUN   ;NO LINE # ARGUMENT
  JP NC,_RUN_FILE

__RUN_0:             ; Initialise variables      ;CLEAN UP -- RESET THE STACK, DATPTR,VARIABLES ...
                                                 ;[H,L] IS THE ONLY THING PRESERVED
  CALL _CLVAR                                    
  LD BC,NEWSTT                                   ;PUT "NEWSTT" ON AND FALL INTO "GOTO"
  JP RUNLIN

; 'GOSUB' BASIC command
; Routine at 2334
;
; A "GOSUB" ENTRY ON THE STACK HAS THE FOLLOWING FORMAT
;
; LOW ADDRESS
;
;	A TOKEN EQUAL TO $GOSUB 1 BYTE
;	THE LINE # OF THE THE "GOSUB" STATEMENT 2 BYTES
;	A POINTER INTO THE TEXT OF THE "GOSUB" 2 BYTES
;
; HIGH ADDRESS
;
; TOTAL 5 BYTES
;
__GOSUB:
  LD C,$03         ; 3 Levels of stack needed         ;"GOSUB" ENTRIES ARE 5 BYTES LONG
  CALL CHKSTK      ; Check for 3 levels of stack      ;MAKE SURE THERE IS ROOM
  POP BC           ; Get return address               ;POP OFF RETURN ADDRESS OF "NEWSTT"
  PUSH HL          ; Save code string for RETURN      ;REALLY PUSH THE TEXT POINTER
  PUSH HL          ; And for GOSUB routine            ;SAVE TEXT POINTER
  LD HL,(CURLIN)   ; Get current line                 ;GET THE CURRENT LINE #
  EX (SP),HL       ; Into stack - Code string out     ;PUT CURLIN ON THE STACK AND [H,L]=TEXT PTR
  LD BC,$0000      
  PUSH BC          
  LD BC,NEWSTT  
  LD A,TK_GOSUB    ; "GOSUB" token
  PUSH AF          ; Save token                       ;PUT GOSUB TOKEN ON THE STACK
  INC SP           ; Don't save flags                 ;THE GOSUB TOKEN TAKES ONLY ONE BYTE
  
  
; This entry point is used by the routine at __RUN.
RUNLIN:                                            ; CONTINUE WITH SUBROUTINE
  PUSH BC          ; Save return address           ; RESTORE RETURN ADDRESS OF "NEWSTT"
                                                   ; AND SEARCH. IN THE 8K WE START WHERE WE
                                                   ; ARE IF WE ARE GOING TO A FORWARD LOCATION.

; Routine at 2358
;
; Used by the routine at __IF.
__GOTO:
  CALL ATOH        			; ASCII number to DE binary     ;PICK UP THE LINE # AND PUT IT IN [D,E]
; This entry point is used by the routine at __RESUME.
__GOTO_0:
  CALL __REM				; Get end of line                 ;SKIP TO THE END OF THIS LINE
  INC HL                    ; Start of next line              ;POINT AT THE LINK BEYOND IT
  PUSH HL                   ; Save Start of next line         ;SAVE THE POINTER
  LD HL,(CURLIN)            ; Get current line                ;GET THE CURRENT LINE #
  RST CPDEHL                ; Line after current?   ;[D,E] CONTAINS WHERE WE ARE GOING, [H,L] CONTAINS THE CURRENT LINE #
                                                    ;SO COMPARING THEM TELLS US WHETHER TO START SEARCHING FROM WHERE 
                                                    ;WE ARE OR TO START SEARCHING FROM THE BEGINNING OF TXTTAB
  POP HL                    ; Restore Start of next line      ; [H,L]=CURRENT POINTER
  CALL C,SRCHLP             ; Line is after current line      ; SEARCH FROM THIS POINT
  CALL NC,SRCHLN            ; Line is before current line     ; SEARCH FROM THE BEGINNING
                                                              ; -- ACTUALLY SEARCH AGAIN IF ABOVE SEARCH FAILED
  LD H,B                    ; Set up code string address: [H,L]= POINTER TO THE START OF THE MATCHED LINE
  LD L,C                    ; NOW POINTING AT THE FIRST BYTE OF THE POINTER TO THE START OF THE NEXT LINE
  DEC HL                    ; Incremented after
  RET C                     ; Line found: GO TO NEWSTT

; entry for '?UL ERROR'
;
; Used by the routines at PROMPT, ON_ERROR and __RESTORE.
UL_ERR:
  LD E,$08			; Err $08 - "Undefined line number"       ;LINE NOT FOUND, DEATH
  JP ERROR          ;C=MATCH, SO IF NO MATCH WE GIVE A "US" ERROR


;
; SEE "GOSUB" FOR THE FORMAT OF THE STACK ENTRY
; "RETURN" RESTORES THE LINE NUMBER AND TEXT POINTER ON THE STACK
; AFTER ELIMINATING ALL THE "FOR" ENTRIES IN FRONT OF THE "GOSUB" ENTRY
;
; This entry point is used by the routine at CLR_ALLINT.
DO_GOSUB:
  PUSH HL           ; Save code string for RETURN
  PUSH HL           ; And for GOSUB routine
  LD HL,(CURLIN)    ; Get current line
  EX (SP),HL        ; Into stack - Code string out   ;PUT RETURN ADDRESS OF "NEWSTT" BACK ONTO THE STACK.
                                                     ;GET TEXT POINTER FROM "GOSUB" SKIP OVER SOME CHARACTERS
                                                     ;SINCE WHEN "GOSUB" STUCK THE TEXT POINTER ONTO THE STACK
                                                     ;THE LINE # ARGUMENT HADN'T BEEN READ IN YET.
  PUSH BC
  LD A,TK_GOSUB     ; Token for 'GOSUB'
  PUSH AF           ; Save token
  INC SP            ; Don't save flags
  EX DE,HL
  DEC HL
  LD (SAVTXT),HL
  INC HL
  JP GONE4

; Routine at 2406
__RETURN:
  RET NZ            	; Return if not just RETURN       ;BLOW HIM UP IF THERE ISN'T A TERMINATOR
  LD D,$FF          	; Flag "GOSUB" search             ;MAKE SURE THIS VARIABLE POINTER IN [D,E] NEVER GETS MATCHED
  CALL BAKSTK       	; Look "GOSUB" block              ;GO PAST ALL THE "FOR" ENTRIES
  CP TK_GOSUB           ; Token for 'GOSUB'
  JP Z,__RETURN_0
  DEC HL
__RETURN_0:
  LD SP,HL              ; Kill all FORs in subroutine
  LD (SAVSTK),HL
  LD E,$03				; Err $03 - RETURN without GOSUB   (RG_ERROR)
  JP NZ,ERROR           ; Error if no "GOSUB" found
  POP HL                ;  (?? GET LINE # "GOSUB" WAS FROM?)
  LD A,H
  OR L
  JP Z,__RETURN_1
  LD A,(HL)
  AND $01
  CALL NZ,RETURN_TRAP
__RETURN_1:
  POP HL                ; Get RETURN line number         ;GET LINE # "GOSUB" WAS FROM
  LD (CURLIN),HL        ; Save as current                ;PUT IT INTO CURLIN
  INC HL                ; Was it from direct statement?
  LD A,H                
  OR L
  JP NZ,RETLIN			; No - Return to line
  LD A,(AUTFLG)         ; Are we in AUTO mode?
  OR A                  ; If so buffer is corrupted
  JP NZ,RESTART         ; Yes - Go to command mode
RETLIN:
  LD HL,NEWSTT       ; Execution driver loop
  EX (SP),HL            ; Into stack - Code string out

  DEFB $3E  ; "LD A,n" to Mask the next byte

; Routine at 2461
;
; Used by the routines at NOTQTI and __READ.
NXTDTA:
  POP HL                ;GET TEXT POINTER OFF STACK

; $099E: DATA statement: find next DATA program line..
;
; Used by the routines at __FOR, __RESUME, __IF and FDTLP.
__DATA:
  DEFB $01              ; "LD BC," TO PICK UP ":" INTO C AND SKIP
  DEFB ':'              ;"DATA" TERMINATES ON ":" AND 0.   ":" ONLY APPLIES IF QUOTES HAVE MATCHED UP

; 'Go to next line'
; Used by 'REM', 'ELSE' (EXECUTED "ELSE"S ARE SKIPPED) and error handling code.
;
; NOTE: REM MUST PRESERVE [D,E] BECAUSE OF "GO TO" AND ERROR
;
__REM:
  DEFB $0E          ;"LD C,"   THE ONLY TERMINATOR IS ZERO
  DEFB 0            ;0 = End of statement

  LD B,$00          ;INSIDE QUOTES THE ONLY TERMINATOR IS ZERO
NXTSTL:
  LD A,C			; Statement and byte   ;WHEN A QUOTE IS SEEN THE SECOND
  LD C,B                                   ;TERMINATOR IS TRADED, SO IN "DATA"
  LD B,A			; Statement end byte   ;COLONS INSIDE QUOTATIONS WILL HAVE NO EFFECT
NXTSTT:
  LD A,(HL)			; Get byte                      ;GET A CHAR
  OR A              ; End of line?                  ;ZERO IS ALWAYS A TERMINATOR
  RET Z             ; Yes - Exit
  CP B              ; End of statement?             ;TEST FOR THE OTHER TERMINATOR
  RET Z             ; Yes - Exit
  INC HL            ; Next byte
  CP '"'            ; Literal string?               ;IS IT A QUOTE?
  JP Z,NXTSTL		; Yes - Look for another '"'    ;IF SO TIME TO TRADE
;
; WHEN AN "IF" TAKES A FALSE BRANCH IT MUST FIND THE APPROPRIATE "ELSE" TO START EXECUTION AT.
; "DATA" COUNTS THE NUMBER OF "IF"S, IT SEES SO THAT THE "ELSE" CODE CAN MATCH "ELSE"S WITH "IF"S.
; THE COUNT IS KEPT IN [D] BECAUSE THEN S HAVE NO COLON
; MULTIPLE IFS CAN BE FOUND IN A SINGLE STATEMENT SCAN
; THIS CAUSES A PROBLEM FOR 8-BIT DATA IN UNQUOTED STRING DATA BECAUSE $IF MIGHT BE MATCHED.
; FIX IS TO HAVE FALSIF IGNORE CHANGES IN [D] IF ITS A DATA STATEMENT
;
  SUB $8A			; TK_IF+1:  IS IT AN "IF"
  JP NZ,NXTSTT      ; IF NOT, CONTINUE ON
  CP B              ;SINCE "REM" CAN'T SMASH [D,E] WE HAVE TO BE CAREFUL
                    ;SO ONLY IF B DOESN'T EQUAL ZERO WE INCREMENT D. (THE "IF" COUNT)
  ADC A,D           ;CARRY ON IF [B] NOT ZERO
  LD D,A            ;UPDATE [D]
  JP NXTSTT			; Keep looking

; Routine at 2493
; LETCON IS LET ENTRY POINT WITH VALTYP-3 IN [A]
; BECAUSE GETYPR HAS BEEN CALLED
LETCON:
  POP AF            ;GET VALTYPE OFF STACK
  ADD A,$03         ;MAKE VALTYPE CORRECT
  JP __LET_0        ;CONTINUE

; Perform the variable assignment in the buffer pointed to by HL.
;
; Used by the routines at __FOR and STATEMENT.
__LET:
  CALL GETVAR       ;GET THE POINTER TO THE VARIABLE NAMED IN TEXT AND PUT IT INTO [D,E]
  RST SYNCHR
  DEFB TK_EQUAL     ;CHECK FOR "="
  EX DE,HL          ;MUST SET UP TEMP FOR "FOR"
  LD (TEMP),HL      ;UP HERE SO WHEN USER-FUNCTIONS
  EX DE,HL          ;CALL REDINP, TEMP DOESN'T GET CHANGED
  PUSH DE
  LD A,(VALTYP)     ; Get data type
  PUSH AF           ; save type         ;CALL REDINP, TEMP DOESN'T GET CHANGED
  CALL EVAL                             ;GET THE VALUE OF THE FORMULA
  POP AF            ; Restore type      ;GET THE VALTYP OF THE VARIABLE INTO [A] INTO FAC

; This entry point is used by the routines at __ELSE and __LINE.
__LET_0:
  EX (SP),HL        ;[H,L]=POINTER TO VARIABLE TEXT POINTER TO ON TOP OF STACK
; This entry point is used by the routine at __READ.
__LET_1:
  LD B,A            ;SAVE VALTYP
  LD A,(VALTYP)     ;GET PRESENT VALTYPE
  CP B              ;COMPARE THE TWO
  LD A,B            ;GET BACK CURRENT
  JP Z,__LET_2      ;VALTYPE ALREADY SET UP, GO!

  CALL CHKTYP       ;FORCE VALTPES TO BE [A]'S
  LD A,(VALTYP)     ;GET PRESENT VALTYPE
__LET_2:
  LD DE,FACCU       ;ASSUME THIS IS WHERE TO START MOVEING
  CP $02            ;IS IT?   ; (Integer ?)
  JP NZ,__LET_3     ;YES
  LD DE,FACLOW      ;NO, USE D.P. FAC
__LET_3:
  PUSH HL           ;SAVE THE POINTER AT THE VALUE POSITION
  CP $03            ; String ?
  JP NZ,LETNUM      ;NUMERIC, SO FORCE IT AND COPY

  LD HL,(FACLOW)	; Pointer to string entry          ;GET POINTER TO THE DESCRIPTOR OF THE RESULT
  PUSH HL			; Save it on stack                 ;SAVE THE POINTER AT THE DESCRIPTOR
  INC HL			; Skip over length
  LD E,(HL)			; LSB of string address
  INC HL
  LD D,(HL)			; MSB of string address
IF KC85 | M10
  LD HL,BUFFER      ;IF THE DATA IS IN BUF, OR IN DISK RANDOM BUFFER, COPY.
ENDIF
IF M100
  LD HL,BUFMIN      ;IF THE DATA IS IN BUF, OR IN DISK RANDOM BUFFER, COPY.
ENDIF
  RST CPDEHL			; Compare HL with DE.. is string before program?
  JP C,__LET_5
  LD HL,(STREND)	;SEE IF IT POINTS INTO STRING SPACE
  RST CPDEHL        ;Is string literal in program?    IF NOT DON'T COPY
  POP DE            ;GET BACK THE POINTER AT THE DESCRIPTOR
  JP NC,DNTCPY      ;DON'T COPY LITERALS
  LD HL,DSCTMP-1    ;NOW, SEE IF ITS A VARIABLE
  RST CPDEHL        ;BY SEEING IF THE DESCRIPTOR IS IN THE TEMPORARY STORAGE AREA (BELOW DSCTMP)
  JP C,__LET_4
  LD HL,TEMPST-1
  RST CPDEHL
  JP C,DNTCPY          ;DON'T COPY IF ITS NOT A VARIABLE
  
__LET_4:
  ;LD A,$D1
	DEFB $3E  ; "LD A,n" to Mask the next byte
	
; Routine at 2589
;
; Used by the routine at __LET.
__LET_5:
  POP DE                  ;GET THE POINTER TO THE DESCRIPTOR IN [D,E]

  CALL FRETMS       ;FREE UP A TEMORARY POINTING INTO BUF    (Back to last tmp-str entry)
  EX DE,HL          ;STRCPY COPIES [H,L]
  CALL STRCPY       ;COPY VARIABLES IN STRING SPACE OR STRINGS WITH DATA IN BUF

; a.k.a MVSTPT
DNTCPY:
  CALL FRETMS       ;FREE UP THE TEMPORARY WITHOUT FREEING UP ANY STRING SPACE (Back to last tmp-str entry)
  EX (SP),HL        ;[H,L]=PLACE TO STORE THE DESCRIPTOR
                    ;LEAVE A NONSENSE ENTRY ON THE STACK, SINCE THE "POP DE" DOESN'T EVER MATTER IN THIS CASE
LETNUM:
  CALL FP2HL        ;COPY A DESCRIPTOR OR A VALUE
  POP DE            ;FOR "FOR" POP OFF A POINTER AT THE LOOP VARIABLE INTO [D,E]
  POP HL            ;GET THE TEXT POINTER BACK
  RET

; 'ON' BASIC instruction
; ON..GOTO, ON ERROR GOTO CODE
;
; Routine at 2607
__ON:
  CP $94            ; (TK_ERROR)  ;"ON...ERROR"?
  JP NZ,ON_OTHER    ;NO.

; Routine at 2612
;ON_ERROR:
  RST CHRGTB        ;GET NEXT THING
  RST SYNCHR        
  DEFB TK_GOTO      ;MUST HAVE ...GOTO
  CALL ATOH         ;GET FOLLOWING LINE #
  LD A,D            ;IS LINE NUMBER ZERO?
  OR E              ;SEE
  JP Z,__ON_0       ;IF ON ERROR GOTO 0, RESET TRAP
  CALL FNDLN1       ;SEE IF LINE EXISTS (SAVE [H,L] ON STACK)	..Sink HL in stack and get first line number
  LD D,B            ;GET POINTER TO LINE IN [D,E]
  LD E,C            ;(LINK FIELD OF LINE)
  POP HL            ;RESTORE [H,L]
  JP NC,UL_ERR      ;ERROR IF LINE NOT FOUND.. Err $08 - "Undefined line number"
__ON_0:
  EX DE,HL          ;GET LINE POINTER IN [H,L]
  LD (ONELIN),HL    ;SAVE POINTER TO LINE OR ZERO IF 0.
  EX DE,HL          ;BACK TO NORMAL
  RET C             ;YOU WOULDN'T BELIEVE IT IF I TOLD YOU
  LD A,(ONEFLG)     ;ARE WE IN AN "ON...ERROR" ROUTINE?
  OR A              ;SET CONDITION CODES
  LD A,E            ;WANT AN EVEN STACK PTR. FOR 8086
  RET Z             ;IF NOT, HAVE ALREADY DISABLED TRAPPING.
  LD A,(ERR_CODE)   ;GET ERROR CODE
  LD E,A            ;INTO E.
  JP ERRESM         ;FORCE THE ERROR TO HAPPEN
  
; This entry point is used by the routine at __ON.
ON_OTHER:
  CALL ON_OPTIONS	; ON_COM, ON_MDM, ON_KEY, ON_TIME$...
  JP C,NTOERR       ; AN "ON ... GOSUB" PERHAPS?
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR        ;   Check syntax: next byte holds the byte to be found
  DEFB TK_GOSUB     ; ..must be GOSUB.  Otherwise error
  XOR A
ON_ERRESM:
  POP BC
  PUSH BC
  CP C
  JP NC,SN_ERR
  PUSH AF
  CALL ATOH
  LD A,D
  OR E
  JP Z,ON_ERRMOR
  CALL FNDLN1
  LD D,B
  LD E,C
  POP HL
  JP NC,UL_ERR

ON_ERRMOR:
  POP AF
  POP BC
  PUSH AF
  ADD A,B
  PUSH BC
  CALL ON_TIME_S_0
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP BC
  POP DE
  RET Z
  PUSH BC
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  POP AF
  INC A
  JP ON_ERRESM

; Not 'ON ERROR'  
NTOERR:
  CALL GETINT                 ; Get integer 0-255                  ;GET VALUE INTO [E]
  LD A,(HL)                   ; Get "GOTO" or "GOSUB" token        ;GET THE TERMINATOR BACK
  LD B,A                      ; Save in B                          ;SAVE THIS CHARACTER FOR LATER
  CP TK_GOSUB                 ; "GOSUB" token?                     ;AN "ON ... GOSUB" PERHAPS?
  JP Z,ONGO                   ; Yes - Find line number             ;YES, SOME FEATURE USE
  RST SYNCHR                  ; Make sure it's "GOTO"              
  DEFB TK_GOTO	              ; "GOTO" token                       ;OTHERWISE MUST BE "GOTO"
  DEC HL                      ; Cancel increment                   ;BACK UP CHARACTER POINTER

ONGO:                         
  LD C,E                      ; Integer of branch value
ONGOLP:                       
  DEC C                       ; Count branches
  LD A,B                      ; Get "GOTO" or "GOSUB" token
  JP Z,STATEMENT              ; Go to that line if right one
  CALL ATOH_2                 ; Get line number to DE
  CP ','                      ; Another line number?          ;A COMMA
  RET NZ                      ; No - Drop through, IF A COMMA DOESN'T DELIMIT THE END OF THE
                              ; CURRENT LINE #, WE MUST BE THE END OF THE LINE
  JP ONGOLP                   ; Yes - loop                    ;CONTINUE GOBBLING LINE #S

; Routine at 2736
__RESUME:
  LD A,(ONEFLG)               ;GET FLAG
  OR A                        ;TRAP ROUTINE.
  JP NZ,__RESUME_0            ;No error, continue
  LD (ONELIN),A
  LD (ONELIN+1),A
  JP RW_ERR                   ; "RESUME without error"
  
__RESUME_0:
  INC A                       ;MAKE A=0
  LD (ERR_CODE),A             ;CLEAR ERROR FLAG SO ^C DOESN'T GIVE ERROR
  LD A,(HL)                   ;GET CURRENT CHAR BACK
  CP $82	                  ;(TK_NEXT): RESUME NEXT?
  JP Z,RESNXT                 ;YUP.
  CALL ATOH                   ;GET FOLLOWING LINE #
  RET NZ                      ;SHOULD TERMINATE
  LD A,D                      ;IS LINE NUMBER ZERO?
  OR E                        ;TEST
  JP Z,RES_NOLINE             
  CALL __GOTO_0               ;DO A GOTO THAT LINE.
  XOR A
  LD (ONEFLG),A         ; Clear 'on error' flag
  RET
  
RESNXT:
  RST CHRGTB                  ;MUST TERMINATE
  RET NZ                      ;BLOW HIM UP
  JP RESTXT
  
RES_NOLINE:
  XOR A
  LD (ONEFLG),A               ; Clear 'on error' flag
  INC A                       ;SET NON ZERO CONDITION CODES
RESTXT:
  LD HL,(ERRTXT)              ;GET POINTER INTO LINE.
  EX DE,HL                    ;SAVE ERRTXT IN [D,E]
  LD HL,(ERRLIN)              ;GET LINE #
  LD (CURLIN),HL              ;SAVE IN CURRENT LINE #
  EX DE,HL
  RET NZ                      ;GO TO NEWSTT IF JUST "RESUME"
  LD A,(HL)                   ;GET ":" OR LINE HEADER
  OR A                        ;SET CC
  JP NZ,NOTBGL                ;#0 MEANS MUST BE ":"
  INC HL                      ;SKIP HEADER
  INC HL
  INC HL
  INC HL
NOTBGL:
  INC HL                      ;POINT TO START OF THIS STATEMENT
  LD A,D
  AND E
  INC A
  JP NZ,__RESUME_5
  LD A,(AUTFLG)
  DEC A
  JP Z,INPBRK
__RESUME_5:
  XOR A
  LD (ONEFLG),A               ; Clear 'on error' flag
  JP __DATA                   ;GET NEXT STMT


; 'ERROR' BASIC command
;
; THIS IS THE ERROR <CODE> STATEMENT WHICH FORCES
; AN ERROR OF TYPE <CODE> TO OCCUR
; <CODE> MUST BE .GE. 0 AND .LE. 255
;
; Routine at 2831
__ERROR:
  CALL GETINT           ;GET THE PARAM
  RET NZ                ;SHOULD HAVE TERMINATED
  OR A                  ;ERROR CODE 0?
  JP Z,FC_ERR			;YES, ERROR IN ITSELF, Err $05 - "Illegal function call"
  JP ERROR              ;FORCE AN ERROR


; 'IF'..'THEN' BASIC code
; Routine at 2842
__IF:
  CALL EVAL             ; Evaluate expression (FORMULA)
  LD A,(HL)             ; Get token
  CP ','                ; "," GET TERMINATING CHARACTER OF FORMULA
  CALL Z,__CHRGTB       ; IF SO SKIP IT
  CP TK_GOTO            ; "GOTO" token?
  JP Z,IFGO             ; Yes - Get line
  RST SYNCHR 			; Make sure it's "THEN"
  DEFB $CD				; "THEN" token
  DEC HL                ; Cancel increment
IFGO:                   
  PUSH HL               ; SAVE THE TEXT POINTER
  CALL __TSTSGN         ; Test state of expression        
  POP HL                ; GET BACK THE TEXT POINTER
  JP Z,FALSE_IF         ; False - Drop through, HANDLE POSSIBLE "ELSE"
DOCOND:
  RST CHRGTB			; Get next character
  JP C,__GOTO           ; Number - GOTO that line
  JP ONJMP				; Otherwise do statement (EXECUTE STATEMENT, NOT GOTO)

;
; "ELSE" HANDLER. HERE ON FALSE "IF" CONDITION
;
FALSE_IF:
  LD D,$01
SKPMRF:
  CALL __DATA           ;SKIP A STATEMENT
  ;":" IS STUCK IN FRONT OF "ELSE"S SO THAT "DATA" WILL STOP BEFORE "ELSE" CLAUSES
  OR A                  ;END OF LINE?
  RET Z                 ;IF SO, NO "ELSE" CLAUSE
  RST CHRGTB			;SEE IF WE HIT AN "ELSE"
  CP $91				
  JP NZ,SKPMRF          ;NO, STILL IN THE "THEN" CLAUSE
  DEC D                 ;DECREMENT THE NUMBER OF "ELSE"S THAT MUST BE SEEN
  JP NZ,SKPMRF          ;SKIP MORE IF HAVEN'T SEEN ENOUGH
  JP DOCOND             ;FOUND THE RIGHT "ELSE" -- GO EXECUTE

; Routine at 2894
__LPRINT:
  LD A,$01              ;SAY NON ZERO
  LD (PRTFLG),A         ;SAVE AWAY
  JP MRPRNT             ; a.k.a. NEWCHR

; Routine at 2902
__PRINT:
  LD C,$02              ;SETUP OUTPUT FILE
  CALL FILGET           ; Get stream number (C=default #channel)
  CP '@'
  CALL Z,PRINT_AT
; This entry point is used by the routine at __LPRINT.
MRPRNT:
  DEC HL                ; DEC 'cos GETCHR INCs
  RST CHRGTB            ; GET ANOTHER CHARACTER
  CALL Z,OUTDO_CRLF     ; CRLF if just PRINT    (IF END WITHOUT PUNCTUATION)
; This entry point is used by the routine at TAB.
PRNTLP:
  JP Z,FINPRT     ; End of list - Exit (FINISH BY RESETTING FLAGS)
                  ; IN WHICH CASE A TERMINATOR DOES NOT MEAN WE SHOULD TYPE A CRLF BUT JUST RETURN
  CP TK_USING       ; USING
  JP Z,USING                                         ;IS IT "PRINT USING" ?
  CP TK_TAB         ; "TAB(" token?                  ;IF SO, USE A SPECIAL HANDLER
  JP Z,TAB          ; Yes - Do TAB routine           
  PUSH HL           ; Save code string address       ;THE TAB FUNCTION?
  CP ','            ; Comma?                         ;IS IT A COMMA?
  JP Z,DOCOM    	; Yes - Move to next zone
  CP ';'            ; Semi-colon?                    ;IS IT A ";"
  JP Z,NEXITM       ; Do semi-colon routine
  POP BC            ; Code string address to BC      ;GET RID OF OLD TEXT POINTER
  CALL EVAL         ; Evaluate expression            ;EVALUATE THE FORMULA
  PUSH HL           ; Save code string address       ;SAVE TEXT POINTER
  RST GETYPR		; Get the number type (FAC)      ;SEE IF WE HAVE A STRING
  JP Z,PRNTST		; JP If string type              ;IF SO, PRINT SPECIALY
  CALL FOUT         ; Convert number to text         ;MAKE A NUMBER INTO A STRING
  CALL CRTST        ; Create temporary string        ;MAKE IT  A STRING
  LD (HL),' '       ; Followed by a space            ;PUT A SPACE AT THE END
  LD HL,(FACLOW)    ; Get length of output           ;AND INCREASE SIZE BY 1
  INC (HL)          ; Plus 1 for the space           ;SIZE BYTE IS FIRST IN DESCRIPTOR

; Output string contents (a.k.a. STRDON)
; USE FOLDING FOR STRINGS AND #S
  CALL ISFLIO       ;DISK OUTPUT?  IF SO, DON'T EVER FORCE A CRLF
  JP NZ,PRNTNB
  LD HL,(FACLOW)    ;GET THE POINTER
  LD A,(PRTFLG)     
  OR A              
  JP Z,ISTTY        ;LPT OR TTY?
  LD A,(LPTPOS)     ;GET WIDTH OF PRINTER
  ADD A,(HL)
  CP $FF            ;IS IT INFINITE? (255="infinite")
  JP LINCH2         ;THEN JUST PRINT
  
ISTTY:
  LD A,(ACTV_Y)      ; Get width of line  -> Number of active columns on screen (1-40), a.k.a. LWIDTH
  LD B,A             ; To B
  INC A              ; Width 255 (No limit)?
  JP Z,PRNTNB        ; Yes - Output number string
  LD A,(TTYPOS)      ; Get cursor position
  ADD A,(HL)         ; Add length of string
  DEC A              ; Adjust it
  CP B               ; Will output fit on this line?
LINCH2:
  JP C,PRNTNB        ; START ON A NEW LINE
  CALL Z,CRFIN
  CALL NZ,OUTDO_CRLF
PRNTNB:
  CALL PRS1          ; Output string at (HL)
  OR A               ; Skip CALL by resetting "Z" flag

; Output string contents (a.k.a. STRDON)
; USE FOLDING FOR STRINGS AND #S
;
; Used by the routine at __PRINT.
PRNTST:
  CALL Z,PRS1        ; Output string at (HL)
  POP HL             ; Restore code string address
  JP MRPRNT          ; See if more to PRINT

; "," found in PRINT list
DOCOM:
  LD BC,$0008        ;(NMLO.C) if file output, SPECIAL PRINT POSITION SHOULD BE FETCHED FROM FILE DATA
  LD HL,(PTRFIL)
  ADD HL,BC          ;[H,L] POINT AT POSITION..
  CALL ISFLIO        ;OUTPUTING INTO A FILE?
  LD A,(HL)          ;IF FILE IS ACTIVE
  JP NZ,ZONELP
  LD A,(PRTFLG)      ;OUTPUT TO THE LINE PRINTER?
  OR A               ;NON-ZERO MEANS YES
  JP Z,ISCTTY        ;NO, DO TELETYPE COMMA
  LD A,(LPTPOS)      ;OUTPUT TO THE LINE PRINTER?
  CP $EE             ;CHECK IF MAX COMMA FIELDS
  JP CHKCOM          ;USE TELETYPE CHECK
  
ISCTTY:
  LD A,(CLMLST)         ;Column space, POSITION BEYOND WHICH THERE ARE NO MORE COMMA FIELDS
  LD B,A
  LD A,(TTYPOS)         ;GET TELETYPE POSITION
  CP B
CHKCOM:
  CALL NC,OUTDO_CRLF    ;TYPE CRLF
  JP NC,NEXITM          ;AND QUIT IF BEYOND THE LAST COMMA FIELD

; a.k.a MORCOM
ZONELP:
  SUB 14             ; (CLMWID) Next zone of 14 characters
  JP NC,ZONELP       ; Repeat if more zones
  CPL                ; Number of spaces to output
                     ; WE WANT TO  FILL THE PRINT POSITION OUT TO AN EVEN CLMWID,
                     ; SO WE PRINT CLMWID-[A] MOD CLMWID SPACES
  JP ASPCS           ; Output them             ;GO PRINT [A]+1 SPACES

; Routine at 3073
;
; Used by the routine at __PRINT.
TAB:
  CALL FNDNUM		; Numeric argument (0..255)        ;EVALUATE THE ARGUMENT
  RST SYNCHR 		; Make sure ")" follows
  DEFB ')'          
  DEC HL            ; Back space on to ")"
  PUSH HL
  LD BC,$0008       ;(NMLO.C) if file output, SPECIAL PRINT POSITION SHOULD BE FETCHED FROM FILE DATA
  LD HL,(PTRFIL)
  ADD HL,BC         ;[H,L] POINT AT POSITION
  CALL ISFLIO       ;OUTPUTING INTO A FILE?  (IF SO, [PTRFIL] .NE. 0)
  LD A,(HL)         ;IF FILE IS ACTIVE
  JP NZ,DOSPC       ;DO TAB CALCULATION NOW
  LD A,(PRTFLG)     ;LINE PRINTER OR TTY?
  OR A              ;NON-ZERO MEANS LPT
  JP Z,TTYIST
  LD A,(LPTPOS)     ; Get current printer position     ;GET LINE PRINTER POSITION
  JP DOSPC          ;GET THE LINE LENGTH
TTYIST:
  LD A,(TTYPOS)     ; Get current position        ;GET TELETYPE PRINT POSITION
DOSPC:
  CPL               ; Number of spaces to print to     ;PRINT [E]-[A] SPACES
  ADD A,E           ; Total number to print
  JP NC,NEXITM      ; TAB < Current POS(X)
; This entry point is used by the routine at __PRINT.
ASPCS:
  INC A             ; Output A spaces
  LD B,A            ; Save number to print             ;[B]=NUMBER OF SPACES TO PRINT
  LD A,' '          ; Space                            ;[A]=SPACE
SPCLP:            
  RST OUTDO          ; Output character in A            ;PRINT [A]
  DEC B             ; Count them                       ;DECREMENT THE COUNT
  JP NZ,SPCLP       ; Repeat if more
  
; This entry point is used by the routine at __PRINT.
; Move to next item in the PRINT list
NEXITM:
  POP HL            ; Restore code string address      ;PICK UP TEXT POINTER
  RST CHRGTB		; Get next character               ;AND THE NEXT CHARACTER
  ;AND SINCE WE JUST PRINTED SPACES, DON'T CALL CRDO IF IT'S THE END OF THE LINE
  JP PRNTLP         ; More to print

; This entry point is used by the routines at __PRINT, __READ, _CLREG and
; USING.
;
;FINISH 'PRINT' BY RESETTING FLAGS
;(IN WHICH CASE A TERMINATOR DOES NOT MEAN WE SHOULD TYPE A CRLF BUT JUST RETURN)
FINPRT:
  XOR A
  LD (PRTFLG),A
  PUSH HL           ;SAVE THE TEXT POINTER
  LD H,A            ;[H,L]=0
  LD L,A
  LD (PTRFIL),HL	;ZERO OUT PTRFIL  (disabling eventual output redirection)
  POP HL            ;GET BACK THE TEXT POINTER
  RET

; Routine at 3141
__LINE:
  CP TK_INPUT		; Token for INPUT to support the "LINE INPUT" statement
  JP NZ,LINE_GFX
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '#'            ;SEE IF THERE IS A FILE NUMBER
  JP Z,LINE_INPUT   ;DO DISK INPUT LINE
  CALL IDTEST
  LD A,(HL)
  CALL __INPUT_0    ;PRINT QUOTED STRING IF ONE
  CALL GETVAR       ;READ STRING TO STORE INTO
  CALL TSTSTR       ;MAKE SURE ITS A STRING
  PUSH DE           ;SAVE POINTER AT VARIABLE
  PUSH HL           ;SAVE TEXT POINTER
  CALL _INLIN       ;READ A LINE OF INPUT
  POP DE            ;GET TEXT POINTER
  POP BC            ;GET POINTER AT VARIABLE
  JP C,INPBRK       ;IF CONTROL-C, STOP
  PUSH BC           ;SAVE BACK VARIABLE POINTER
  PUSH DE           ;SAVE TEXT POINTER
  LD B,$00          ;SETUP ZERO AS ONLY TERMINATOR
  CALL QTSTR_0      ;LITERALIZE THE INPUT
  POP HL            ;RESTORE [H,L]=TEXT POINTER
  LD A,$03          ;SET THREE FOR STRING
  JP __LET_0        ;DO THE ASSIGNMENT

; text at $0C74
REDO_MSG:
  DEFM "?Redo from start"
  DEFB CR, LF, $00
  
;
; HERE WHEN PASSING OVER STRING LITERAL IN SUBSCRIPT OF VARIABLE IN INPUT LIST
; ON THE FIRST PASS OF INPUT CHECKING FOR TYPE MATCH AND NUMBER
;
; This entry point is used by the routine at __READ.
SCNSTR:
  LD A,(FLGINP)     ;WAS IT READ OR INPUT?
  OR A              ;ZERO=INPUT
  JP NZ,DATSNR      ;GIVE ERROR AT DATA LINE
  POP BC            ;GET RID OF THE POINTER INTO THE VARIABLE LIST
  LD HL,REDO_MSG
  CALL PRS          ;PRINT "?REDO FROM START" TO NEWSTT POINTING AT THE START OF
  LD HL,(SAVTXT)    ;START ALL OVER: GET SAVED TEXT POINTER
  RET               ;GO BACK TO NEWSTT

; Routine at 3225
; INPUT #, set stream number (input channel)
; "set input channel"
;
; Used by the routine at __INPUT.
FILSTI:
  CALL FILINP         	; deal with '#' argument
  PUSH HL
  LD HL,BUFMIN
  JP INPUT_CHANNEL

; Routine at 3235
__INPUT:
  CALL IDTEST
  LD A,(HL)
  CP '#'
  JP Z,FILSTI       ; "set input channel"
  CALL IDTEST
  LD A,(HL)
  LD BC,NOTQTI      ;WHERE TO GO
  PUSH BC           ;WHEN DONE WITH QUOTED STRING

; This entry point is used by the routine at __LINE.
__INPUT_0:
  CP '"'            ; Is there a prompt string?    ;IS IT A QUOTE?
  LD A,$00          ; Clear A and leave flags      ;BE TALKATIVE
  RET NZ            ; not a quote.. JUST RETURN
  CALL QTSTR        ; MAKE THE MESSAGE A STRING
  RST SYNCHR 		; Check for ";" after prompt
  DEFB ';'
  PUSH HL           ; Save code string address     ;REMEMBER WHERE IT ENDED
  CALL PRS1         ; Output prompt string
  POP HL            ; Restore code string address  ;GET BACK SAVED TEXT PTR
  RET               ;ALL DONE
  
; Routine at 3268
NOTQTI:
  PUSH HL
  CALL QINLIN       ; User interaction with question mark, HL = resulting text 
  POP BC            ; Restore code string address      ;TAKE OFF SINCE MAYBE LEAVING
  JP C,INPBRK                                          ;IF EMPTY LEAVE
  INC HL
  LD A,(HL)
  OR A
  DEC HL
  PUSH BC           ; Re-save code string address      ;PUT BACK SINCE DIDN'T LEAVE
  JP Z,NXTDTA


; This entry point is used by the routine at FILSTI.
; 'INPUT' from a stream
INPUT_CHANNEL:
  LD (HL),','       ;SETUP COMMA AT BUFMIN
  JP INPCON

; Routine at 3289
__READ:
  PUSH HL                 ; Save code string address      ;SAVE THE TEXT POINTER
  LD HL,(DATPTR)          ; Next DATA statement           ;GET LAST DATA LOCATION
                                                          
  DEFB $F6                ; OR AFh ..Flag "READ"          ;"ORI" TO SET [A] NON-ZERO

; Routine at 3294
;
; Used by the routine at NOTQTI.
INPCON:
  XOR A                 ; Flag "INPUT"                    ;SET FLAG THAT THIS IS AN INPUT
  LD (FLGINP),A         ; Save "READ"/"INPUT" flag        ;STORE THE FLAG
;
; IN THE PROCESSING OF DATA AND READ STATEMENTS:
; ONE POINTER POINTS TO THE DATA (IE THE NUMBERS BEING FETCHED)
; AND ANOTHER POINTS TO THE LIST OF VARIABLES
;
; THE POINTER INTO THE DATA ALWAYS STARTS POINTING TO A
; TERMINATOR -- A , : OR END-OF-LINE
;
  EX (SP),HL            ; Get code str' , Save pointer    ;[H,L]=VARIABLE LIST POINTER <> DATA POINTER GOES ON THE STACK
  JP GTVLUS             ; Get values  (optimization:  "DEFB $01" would work here in place of the JP instruction)
                       
LOPDT2:
  RST SYNCHR			; Check for comma between items
  DEFB ','              ; MAKE SURE THERE IS A ","
  
; a.k.a. LOPDAT
GTVLUS:
  CALL GETVAR           ;READ THE VARIABLE LIST AND GET THE POINTER TO A VARIABLE INTO [D,E]
                        ;PUT THE VARIABLE LIST POINTER ONTO THE STACK AND TAKE THE DATA LIST POINTER OFF
  EX (SP),HL
;
; NOTE AT THIS POINT WE HAVE A VARIABLE WHICH WANTS DATA
; AND SO WE MUST GET DATA OR COMPLAIN
;
  PUSH DE               ; SAVE THE POINTER TO THE VARIABLE WE ARE ABOUT TO SET UP WITH A VALUE
  ;SINCE THE DATA LIST POINTER ALWAYS POINTS AT A TERMINATOR LETS READ THE TERMINATOR INTO [A] AND SEE WHAT IT IS
  LD A,(HL)
  CP ','                ; Comma?
  JP Z,SCNVAL           ; Yes - Get another value          ;A COMMA SO A VALUE MUST FOLLOW
  LD A,(FLGINP)			; Is it READ?                      ;SEE WHAT TYPE OF STATEMENT THIS WAS
  OR A                 
  JP NZ,FDTLP			; Yes - Find next DATA stmt        ;SEARCH FOR ANOTHER DATA STATEMENT

;THE DATA NOW STARTS AT THE BEGINNING OF THE BUFFER
;AND QINLIN LEAVES [H,L]=BUF

  LD A,'?'				; More INPUT needed
  RST OUTDO				; Output character
  CALL QINLIN			; Get INPUT with prompt, HL = resulting text 
  POP DE
  POP BC
  JP C,INPBRK
  INC HL
  LD A,(HL)
  DEC HL
  OR A
  PUSH BC
  JP Z,NXTDTA
  PUSH DE
  
; This entry point is used by the routine at FDTLP.
SCNVAL:
  CALL ISFLIO       ; SEE IF A FILE READ
  JP NZ,FILIND      ; IF SO, SPECIAL HANDLING
  RST GETYPR        ; IS IT A STRING?
  PUSH AF           ; SAVE THE TYPE INFORMATION
;
; IF NUMERIC, USE FIN TO GET IT
; ONLY THE VARAIBLE TYPE IS CHECKED SO AN UNQUOTED STRING CAN BE ALL DIGITS
;
  JP NZ,INPBIN	    ; If numeric, convert to binary
  RST CHRGTB		; Gets next character
  LD D,A            ; Save input character               ;ASSUME QUOTED STRING
  LD B,A            ; Again                              ;SETUP TERMINATORS
  CP '"'            ; Start of literal sting?            ;QUOTE ?
  JP Z,STRENT       ; Yes - Create string entry          ;TERMINATORS OK
  LD A,(FLGINP)     ; "READ" or "INPUT" ?                ;INPUT SHOULDN'T TERMINATE ON ":"
  OR A                                                   ;SEE IF READ OR INPUT
  LD D,A            ; Save 00 if "INPUT"                 ;SET D TO ZERO FOR INPUT
  JP Z,ITMSEP       ; "INPUT" - End with 00
  LD D,':'          ; "DATA" - End with 00 or ":"        ;UNQUOTED STRING TERMINATORS
ITMSEP:             
  LD B,','          ; Item separator
                    ; NOTE: ANSI USES [B]=44 AS A FLAG TO TRIGGER TRAILING SPACE SUPPRESSION

  DEC HL            ; Back space for DTSTR
                    ; BACKUP SINCE START CHARACTER MUST BE INCLUDED
                    ; IN THE QUOTED STRING CASE WE DON'T WANT TO
                    ; INCLUDE THE STARTING OR ENDING QUOTE

; a.k.a. NOWGET
STRENT:
  ;MAKE A STRING DESCRIPTOR FOR THE VALUE AND COPY IF NECESSARY
  CALL DTSTR        ; Get string terminated by D

DOASIG:
  POP AF            ;POP OFF THE TYPE INFORMATION
  ADD A,$03         ;MAKE VALTYPE CORRECT
  EX DE,HL          ;[D,E]=TEXT POINTER
  LD HL,LTSTND      ;RETURN LOC
  EX (SP),HL        ;[H,L]=PLACE TO STORE VARIABLE VALUE
  PUSH DE           ;TEXT POINTER GOES ON
  JP __LET_1        ;DO ASSIGNMENT

; a.k.a. NUMINS
INPBIN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD BC,DOASIG      ; ASSIGNMENT IS COMPLICATED EVEN FOR NUMERICS SO USE THE "LET" CODE
  PUSH BC           ; SAVE ON STACK
  JP FIN_DBL        ; ELSE CALL SPECIAL ROUTINE WHICH EXPECTS DOUBLES

; Routine at 3397
LTSTND:
  DEC HL
; This entry point is used by the routine at _INLIN.
  RST CHRGTB		; Get next character
  JP Z,MORDT        ; End of line - More needed?
  CP ','            ; Another value?
  JP NZ,SCNSTR      ; No - Bad input
MORDT:            
  EX (SP),HL        ; Get code string address
  DEC HL            ; DEC 'cos GETCHR INCs     ;LOOK AT TERMINATOR
  RST CHRGTB        ; Get next character       ;AND SET UP CONDITION CODES
  JP NZ,LOPDT2      ; More needed - Get it     ;NOT ENDING, CHECK FOR COMMA AND GET
                                               ;ANOTHER VARIABLE TO FILL WITH DATA
  POP DE            ; Restore DATA pointer     ;POP OFF THE POINTER INTO DATA
  LD A,(FLGINP)     ; "READ" or "INPUT" ?      ;FETCH THE STATEMENT TYPE FLAG
  OR A
				;INPUT STATEMENT
  EX DE,HL          ; DATA pointer to HL
  JP NZ,UPDATA      ; Update DATA pointer if "READ"         ;UPDATE DATPTR
  PUSH DE           ; Save code string address              ;SAVE THE TEXT POINTER
  CALL ISFLIO       ; Tests if I/O to device is taking place
  JP NZ,__READ_9
  LD A,(HL)
  OR A
  LD HL,EXTRA_MSG    ; "?Extra ignored"
  CALL NZ,PRS
__READ_9:
  POP HL             ; Restore code string address          ;GET BACK THE TEXT POINTER
  JP FINPRT
  
; Message at 3441
EXTRA_MSG:
  DEFM "?Extra ignored"
  DEFB $0D
  DEFB $0A
  DEFB $00


; Find next DATA statement
;
; THE SEARCH FOR DATA STATMENTS IS MADE BY USING THE EXECUTION CODE
; FOR DATA TO SKIP OVER STATEMENTS. THE START WORD OF EACH STATEMENT
; IS COMPARED WITH $DATA. EACH NEW LINE NUMBER
; IS STORED IN DATLIN SO THAT IF AN ERROR OCCURS WHILE READING
; DATA THE ERROR MESSAGE WILL GIVE THE LINE NUMBER OF THE 
; ILL-FORMATTED DATA
;
; a.k.a. DATLOP
; Used by the routine at __READ.
FDTLP:
  CALL __DATA      ; Get next statement
  OR A             ; End of line?
  JP NZ,FANDT      ; No - See if DATA statement
  INC HL
  LD A,(HL)        ; End of program?
  INC HL
  OR (HL)          ; 00 00 Ends program
  LD E,$04         ; Err $04 - "Out of DATA" (?OD Error)     ;NO DATA IS ERROR ERROD
  JP Z,ERROR       ; Yes - Out of DATA                       ;IF SO COMPLAIN
  INC HL                                                     ;SKIP PAST LINE #
  LD E,(HL)        ; LSB of line number                      ;GET DATA LINE #
  INC HL
  LD D,(HL)        ; MSB of line number
  EX DE,HL
  LD (DATLIN),HL   ; Set line of current DATA item
  EX DE,HL         ;RESTORE TEXT POINTER
FANDT:
  RST CHRGTB       ; Get next character                      ;GET THE STATEMENT TYPE
  CP $83           ; TK_DATA, "DATA" token                   ;IS IS "DATA"?
  JP NZ,FDTLP      ; No "DATA" - Keep looking                ;NOT DATA SO LOOK SOME MORE
  JP SCNVAL        ; Found - Convert input                   ;CONTINUE READING

;
;	FORMULA EVALUATION CODE
;
; THE FORMULA EVALUATOR STARTS WITH [H,L] POINTING TO THE FIRST CHARACTER OF THE FORMULA.
; AT THE END [H,L] POINTS TO THE TERMINATOR.
; THE RESULT IS LEFT IN THE FAC.
; ON RETURN [A] DOES NOT REFLECT THE TERMINATING CHARACTER
;
; THE FORMULA EVALUATOR USES THE OPERATOR TABLE (OPTAB) TO DETERMINE
; PRECEDENCE AND DISPATCH ADDRESSES FOR EACH OPERATOR.
;
; A TEMPORARY RESULT ON THE STACK HAS THE FOLLOWING FORMAT:
; - THE ADDRESS OF 'RETAOP' -- THE PLACE TO RETURN ON COMPLETION OF OPERATOR APPLICATION
; - THE FLOATING POINT TEMPORARY RESULT
; - THE ADDRESS OF THE OPERATOR ROUNTINE
; - THE PRECEDENCE OF THE OPERATOR
;
; TOTAL 10 BYTES
;
; This entry point is used by the routine at INSTR.
FRMEQL:
  RST SYNCHR
  DEFB TK_EQUAL    ; Token for '='         ;CHECK FOR EQUAL SIGN
                                           ;EVALUATE FORMULA AND RETURN
  JP EVAL          ; optimization hint:  DEFB 1, use "LD BC,n" and mask the next 2 bytes

; Chk Syntax, make sure '(' follows
;
; Used by the routines at NVRFIL, UCASE and INSTR.
OPNPAR:
  RST SYNCHR       ; Make sure "(" follows
  DEFB '('         ;GET PAREN BEFORE FORMULA

;
; Used by the routines at TO, STEP, __LET, __IF, __PRINT, FDTLP, FPSINT_0,
; GETINT, GETWORD, __DAY_S, OUTS_B_CHARS, STRING_S, INSTR, USING and FNAME.
; a.k.a. GETNUM, evaluate expression
EVAL:
  DEC HL           ; Evaluate expression & save        ;BACK UP CHARACTER POINTER

; (a.k.a. GETNUM, evaluate expression (GETNUM)
;
; Used by the routines at STEP and USING.
; a.k.a. LPOPER
EVAL_0:
  LD D,$00         ; Precedence value                  ;INITIAL DUMMY PRECEDENCE IS 0

; Save precedence and eval until precedence break
;
; Used by the routines at EVAL3, NVRFIL and NOT.
EVAL_1:
  PUSH DE          ; Save precedence                     ;SAVE PRECEDENCE
  LD C,$01         ; Check for 1 level of stack          ;EXTRA SPACE NEEDED FOR RETURN ADDRESS
  CALL CHKSTK                                            ;MAKE SURE THERE IS ROOM FOR RECURSIVE CALLS
  CALL OPRND       ; Get next expression value           ;EVALUATE SOMETHING

; Evaluate expression until precedence break
;
EVAL2:
  LD (NXTOPR),HL	   ; Save address of next operator

; Evaluate expression until precedence break
;
; Used by the routine at NOT.
EVAL3:
  LD HL,(NXTOPR)		; Restore address of next opr
  POP BC                ; Precedence value and operator          ;POP OFF THE PRECEDENCE OF OLDOP
  LD A,(HL)             ; Get next operator / function           ;GET NEXT CHARACTER
  LD (TEMP3),HL                                                  ;SAVE UPDATED CHARACTER POINTER
  CP TK_PLUS            ; Token code for '+' (lower opr code)    ;IS IT AN OPERATOR?
  RET C                 ; NO, ALL DONE (THIS CAN RESULT IN OPERATOR APPLICATION OR ACTUAL RETURN)                     
  CP TK_MINOR+1         ; '<' +1  (higher opr code)
  RET NC                ; ..Is it + - * / ^ AND OR ?   No - Exit
  CP TK_GREATER			; SOME KIND OF RELATIONAL?
  JP NC,DORELS                                                    ;YES, DO IT
  SUB TK_PLUS			; TK_PLUS, token code for '+'             ;SUBTRAXDCT OFFSET FOR FIRST ARITHMETIC
  LD E,A        		; Coded operator                          ;MUST MULTIPLY BY 3 SINCE OPTAB ENTRIES ARE 3 LONG
  JP NZ,FOPRND                                                    ;NOT ADDITION OP

  LD A,(VALTYP)         ; Get data type                           ;SEE IF LEFT PART IS STRING
  CP $03				; String ?                                ;SEE IF ITS A STRING
  LD A,E                ; Coded operator                          ;REFETCH OP-VALUE
  JP Z,CONCAT           ; If so, string concatenation (use '+' to join strings)

FOPRND:
  LD HL,PRITAB			; ARITHMETIC PRECEDENCE TABLE             ;CREATE INDEX INTO OPTAB
  LD D,$00                                                        ;MAKE HIGH BYTE OF OFFSET=0
  ADD HL,DE             ; To the operator concerned               ;ADD IN CALCULATED OFFSET

; This entry point is used by the routine at __READ.
EVAL3_1:
  LD A,B                ; Last operator precedence
  LD D,(HL)             ; Get evaluation precedence
  CP D                  ; Compare with eval precedence
  RET NC                ; Exit if higher precedence
  PUSH BC               ; Save last precedence & token            ;SAVE THE OLD PRECEDENCE
  LD BC,EVAL3           ; Where to go on prec' break              ;PUT ON THE ADDRESS OF THE
  PUSH BC               ; Save on stack for return                ;PLACE TO RETURN TO AFTER OPERATOR APPLICATION
  LD A,D
  CP $51                ; one less than AND as mapped in PRITAB   ;SEE IF THE OPERATOR IS "AND" OR "OR"
  JP C,EVAL_BOOL                                                  ;AND IF SO "FRCINT" AND MAKE A SPECIAL STACK ENTRY
  AND $FE                                                         ;MAKE 123 AND 122 BOTH MAP TO 122
  CP $7A                ; MOD as mapped in PRITAB                 ;MAKE A SPECIAL CHECK FOR "MOD" AND "IDIV"
  JP Z,EVAL_BOOL                                                  ;IF SO, COERCE ARGUMENTS TO INTEGER

; THIS CODE PUSHES THE CURRENT VALUE IN THE FAC
; ONTO THE STACK, EXCEPT IN THE CASE OF STRINGS IN WHICH IT CALLS
; TYPE MISMATCH ERROR. [D] AND [E] ARE PRESERVED.
;
EVAL_NUMERIC:
  LD HL,FACLOW          ;SAVE THE VALUE OF THE FAC
  LD A,(VALTYP)         ;FIND OUT WHAT TYPE OF VALUE WE ARE SAVING
  SUB $03               ; String ?     SET ZERO FOR STRINGS
  JP Z,TM_ERR           ; "Type mismatch" error
  OR A                  ;SET PARITY -- CARRY UNAFFECTED SINCE OFF
  
  LD HL,(FACLOW)
  PUSH HL               ;PUSH FACLO+0,1 ON THE STACK
  JP M,EVAL_NEXT        ;ALL DONE IF THE DATA WAS AN INTEGER  (Stack this one and get next)
  
  LD HL,(FACCU)
  PUSH HL               ;PUSH FAC-1,0 ON THE STACK
  JP PO,EVAL_NEXT       ;ALL DONE IF WE HAD A SNG  (Stack this one and get next)
  
  LD HL,(FACCU+6)       ;WE HAVE A DOUBLE PRECISON NUMBER
  PUSH HL               ;PUSH ITS 4 LO BYTES ON THE STACK
  LD HL,(FACCU+4)
  PUSH HL

;a.k.a. VPUSHD
EVAL_NEXT:
  ADD A,$03             ; FIX [A] TO BE THE VALTYP OF THE NUMBER JUST PUSHED ON THE STACK
  LD C,E                ; [C]=OPERATOR NUMBER
  LD B,A                ; [B]=TYPE OF VALUE ON THE STACK
  PUSH BC               ; SAVE THESE THINGS FOR APPLOP
  LD BC,APPLOP          ; GENERAL OPERATOR APPLICATION ROUTINE -- DOES TYPE CONVERSIONS

;a.k.a. FINTMP
EVAL_MORE:
  PUSH BC               ; Save routine address              ;SAVE PLACE TO GO
  LD HL,(TEMP3)         ; Address of current operator       ;REGET THE TEXT POINTER
  JP EVAL_1              ; Loop until prec' break            ;PUSH ON THE PRECEDENCE AND READ MORE FORMULA

DORELS:
  LD D,$00       ;ASSUME NO RELATION OPS, ALSO SETUP THE HIGH ORDER OF THE INDEX INTO OPTAB
LOPREL:
  SUB TK_GREATER                ;IS THIS ONE RELATION?
  JP C,FINREL                   ;RELATIONS ALL THROUGH
  CP TK_MINOR-TK_GREATER+1      ;IS IT REALLY RELATIONAL?
  JP NC,FINREL                  ;NO JUST BIG
  CP 1                          ;SET UP BITS BY MAPPING
  RLA                           ;0 TO 1 1 TO 2 AND 2 TO 4
  XOR D                         ;BRING IN THE OLD BITS
  CP D                          ;MAKE SURE RESULT IS BIGGER
  LD D,A                        ;SAVE THE MASK
  JP C,SN_ERR                   ;DON'T ALLOW TWO OF THE SAME
  LD (TEMP3),HL                 ;SAVE CHARACTER POINTER
  RST CHRGTB                    ;GET THE NEXT CANDIDATE
  JP LOPREL

;
; FOR "AND" AND "OR" AND "\" AND "MOD" WE WANT TO FORCE THE CURRENT VALUE
; IN THE FAC TO BE AN INTEGER, AND AT APPLICATION TIME FORCE THE RIGHT
; HAND OPERAND TO BE AN INTEGER
;
EVAL_BOOL:
  PUSH DE                       ;SAVE THE PRECEDENCE
  CALL __CINT                   
  POP DE                        ;[D]=PRECEDENCE
  PUSH HL                       ;PUSH THE LEFT HAND OPERAND
  LD BC,DANDOR                  ;"AND" AND "OR" DOER
  JP EVAL_MORE                  ;PUSH ON THIS ADDRESS,PRECEDENCE AND CONTINUE EVALUATION
  
;
; HERE TO BUILD AN ENTRY FOR A RELATIONAL OPERATOR
; STRINGS ARE TREATED SPECIALLY. NUMERIC COMPARES ARE DIFFERENT
; FROM MOST OPERATOR ENTRIES ONLY IN THE FACT THAT AT THE
; BOTTOM INSTEAD OF HAVING RETAOP, DOCMP AND THE RELATIONAL
; BITS ARE STORED. STRINGS HAVE STRCMP,THE POINTER AT THE STRING DESCRIPTOR,
; DOCMP AND THE RELATIONAL BITS.
;
FINREL:
  LD A,B                    ;[A]=OLD PRECEDENCE
  CP 100                    ;RELATIONALS HAVE PRECEDENCE 100
  RET NC                    ;APPLY EARLIER OPERATOR IF IT HAS HIGHER PRECEDENCE
  PUSH BC                   ;SAVE THE OLD PRECEDENCE
  PUSH DE                   ;SAVE [D]=RELATIONAL BITS
  LD DE,100*256+OPCNT       ;[D]=PRECEDENCE=100
                            ;[E]=DISPATCH OFFSET FOR COMPARES IN APPLOP=4
                            ;IN CASE THIS IS A NUMERIC COMPARE
  LD HL,DOCMP               ;ROUTINE TO TAKE COMPARE ROUTINE RESULT
                            ;AND RELATIONAL BITS AND RETURN THE ANSWER
  PUSH HL                   ;DOES A JMP TO RETAOP WHEN DONE
  RST GETYPR                ;SEE IF WE HAVE A NUMERIC COMPARE
  JP NZ,EVAL_NUMERIC        ;YES, BUILD AN APPLOP ENTRY
  LD HL,(FACLOW)            ;GET THE POINTER AT THE STRING DESCRIPTOR
  PUSH HL                   ;SAVE IT FOR STRCMP
  LD BC,STRCMP              ;STRING COMPARE ROUTINE
  JP EVAL_MORE              ;PUSH THE ADDRESS, REGET THE TEXT POINTER
                            ;SAVE THE PRECEDENCE AND SCAN
                            ;MORE OF THE FORMULA

; Routine at 3692
;
; APPLOP IS RETURNED TO WHEN IT IS TIME TO APPLY AN ARITHMETIC
; OR NUMERIC COMPARISON OPERATION.
; THE STACK HAS A DOUBLE BYTE ENTRY WITH THE OPERATOR
; NUMBER AND THE VALTYP OF THE VALUE ON THE STACK.
; APPLOP DECIDES WHAT VALUE LEVEL THE OPERATION
; WILL OCCUR AT, AND CONVERTS THE ARGUMENTS. APPLOP
; USES DIFFERENT CALLING CONVENTIONS FOR EACH VALUE TYPE.
; INTEGERS: LEFT IN [D,E] RIGHT IN [H,L]
; SINGLES:  LEFT IN [B,C,D,E] RIGHT IN THE FAC
; DOUBLES:  LEFT IN FAC   RIGHT IN ARG
;
APPLOP:
  POP BC                    ;[B]=STACK OPERAND VALUE TYPE  [C]=OPERATOR OFFSET
  LD A,C                    ;SAVE IN MEMORY SINCE THE STACK WILL BE BUSY
  LD (OPRTYP),A             ;A RAM LOCATION
  LD A,(VALTYP)             ;GET VALTYP OF FAC
  CP B                      ;ARE VALTYPES THE SAME?
  JP NZ,VALNSM              ;NO
  CP $02                    ;INTEGER?
  JP Z,INTDPC               ;YES, DISPATCH!!
  CP $04                    ;SINGLE?
  JP Z,SNGDPC               ;YES, DISPATCH!!
  JP NC,DBLDPC              ;MUST BE DOUBLE, DISPATCH!!
VALNSM:
  LD D,A                    ;SAVE IN [D]
  LD A,B                    ;CHECK FOR DOUBLE
  CP $08                    ;PRECISION ENTRY ON THE STACK
  JP Z,STKDBL               ;FORCE FAC TO DOUBLE
  LD A,D                    ;GET VALTYPE OF FAC
  CP $08                    ;AND IF SO, CONVERT THE STACK OPERAND
  JP Z,FACDBL               ;TO DOUBLE PRECISION
  LD A,B                    ;SEE IF THE STACK ENTRY IS SINGLE
  CP $04                    ;PRECISION AND IF SO, CONVERT
  JP Z,STKSNG               ;THE FAC TO SINGLE PRECISION
  LD A,D                    ;SEE IF THE FAC IS SINGLE PRECISION
  CP $03                    ;BLOW UP ON RIGHT HAND STRING OPERAND
  JP Z,TM_ERR               ; Err  - "Type mismatch"
  JP NC,EVAL_FP             ;AND IF SO CONVERT THE STACK TO SINGLE PRECISION

;NOTE: THE STACK MUST BE INTEGER AT THIS POINT

INTDPC:
  LD HL,INT_OPR             ;INTEGER INTEGER CASE
  LD B,$00                  ;SPECIAL DISPATCH FOR SPEED
  ADD HL,BC                 ;[H,L] POINTS TO THE ADDRESS TO GO TO 
  ADD HL,BC
  LD C,(HL)                 ;[B,C]=ROUTINE ADDRESS
  INC HL
  LD B,(HL)
  POP DE                    ;[D,E]=LEFT HAND OPERAND
  LD HL,(FACLOW)            ;[H,L]=RIGHT HAND OPERAND
  PUSH BC                   ;DISPATCH
  RET

;
; THE STACK OPERAND IS DOUBLE PRECISION, SO
; THE FAC MUST BE FORCED TO DOUBLE PRECISION, MOVED INTO ARG
; AND THE STACK VALUE POPED INTO THE FAC
;
STKDBL:
  CALL __CDBL               ;MAKE THE FAC DOUBLE PRECISION
DBLDPC:
  CALL FP_ARG2HL            ;POP OFF THE STACK OPERAND INTO THE FAC
  POP HL
  LD (FACCU+4),HL
  POP HL
  LD (FACCU+6),HL           ;STORE LOW BYTES AWAY
SNGDBL:
  POP BC
  POP DE                    ;POP OFF A FOUR BYTE VALUE
  CALL FPBCDE               ;INTO THE FAC
SETDBL:
  CALL __CDBL               ;MAKE SURE THE LEFT OPERAND IS DOUBLE PRECISION
  LD HL,DEC_OPR             ;DISPATCH TO A DOUBLE PRECISION ROUTINE
DODSP:
  LD A,(OPRTYP)             ;RECALL WHICH OPERAND IT WAS
  RLCA                      ;CREATE A DISPATCH OFFSET, SINCE
  ADD A,L                   ;TABLE ADDRESSES ARE TWO BYTES
  LD L,A                    ;ADD LOW BYTE OF ADDRESS
  ADC A,H                   ;SAVE BACK
  SUB L                     ;ADD HIGH BYTE
  LD H,A                    ;SUBTRACT LOW
  LD A,(HL)                 ;RESULT BACK
  INC HL                    ;GET THE ADDRESS
  LD H,(HL)
  LD L,A
  JP (HL)     ;AND PERFORM THE OPERATION, RETURNING TO RETAOP, EXCEPT FOR COMPARES WHICH RETURN TO DOCMP
  
;
; THE FAC IS DOUBLE PRECISION AND THE STACK IS EITHER
; INTEGER OR SINGLE PRECISION AND MUST BE CONVERTED
; 
FACDBL:
  LD A,B
  PUSH AF                   ;SAVE THE STACK VALUE TYPE
  CALL FP_ARG2HL            ;MOVE THE FAC INTO ARG
  POP AF                    ;POP THE STACK VALUE TYPE INTO [A]
  LD (VALTYP),A             ;PUT IT IN VALTYP FOR THE FORCE ROUTINE
  CP $04                    ;SEE IF ITS SINGLE, SO WE KNOW HOW TO POP THE VALUE OFF
  JP Z,SNGDBL               ;IT'S SINGLE PRECISION SO DO A POPR / CALL MOVFR
  POP HL                    ;POP OFF THE INTEGER VALUE
  LD (FACLOW),HL            ;SAVE IT FOR CONVERSION
  JP SETDBL                 ;SET IT UP

;
; THIS IS THE CASE WHERE THE STACK IS SINGLE PRECISION
; AND THE FAC IS EITHER SINGLE PRECISION OR INTEGER
;
STKSNG:
  CALL __CSNG               ;CONVERT THE FAC IF NECESSARY
SNGDPC:
  POP BC                    ;PUT THE LEFT HAND OPERAND IN THE REGISTERS
  POP DE
SNGDO:
  LD HL,FLT_OPR             ;SETUP THE DISPATCH ADDRESS FOR THE SINGLE PRECISION OPERATOR ROUTINES
  JP DODSP                  ;DISPATCH

;
; THIS IS THE CASE WHERE THE FAC IS SINGLE PRECISION AND THE STACK
; IS AN INTEGER. 
;
EVAL_FP:
  POP HL                    ;POP OFF THE INTEGER ON THE STACK
  CALL STAKI                ;SAVE THE FAC ON THE STACK
  CALL HL_CSNG              ;CONVERT [H,L] TO A SINGLE PRECISION NUMBER IN THE FAC
  CALL BCDEFP               ;PUT THE LEFT HAND OPERAND IN THE REGISTERS
  POP HL                    ;RESTORE THE FAC
  LD (FACCU),HL             ;FROM THE STACK
  POP HL
  LD (FACLOW),HL
  JP SNGDO                  ;PERFORM THE OPERATION

;
; HERE TO DO INTEGER DIVISION. SINCE WE WANT 1/3 TO BE
; .333333 AND NOT ZERO WE HAVE TO FORCE BOTH ARGUMENTS
; TO BE SINGLE-PRECISION FLOATING POINT NUMBERS
; AND USE FDIV
;
; Integer Divide (FAC1=DE/HL)
IDIV:
  PUSH HL                   ;SAVE THE RIGHT HAND ARGUMENT
  EX DE,HL                  ;[H,L]=LEFT HAND ARGUMENT
  CALL HL_CSNG              ;CONVERT [H,L] TO A SINGLE-PRECISION NUMBER IN THE FAC
  POP HL                    ;GET BACK THE RIGHT HAND ARGUMENT
  CALL STAKI                ;PUSH THE CONVERTED LEFT HAND ARGUMENT ONTO THE STACK
  CALL HL_CSNG              ;CONVERT THE RIGHT HAND ARGUMENT TO A SINGLE PRECISION NUMBER IN THE FAC
  JP DIVIDE                 ;DO THE DIVISION AFTER POPING INTO THE REGISTERS THE LEFT HAND ARGUMENT


; Get next expression value (a.k.a. "EVAL" !)
; Used by the routines at EVAL_1 and CONCAT.
OPRND:
  RST CHRGTB			; Gets next character (or token) from BASIC text.
  JP Z,MO_ERR			;TEST FOR MISSING OPERAND - IF NONE, Err $18 - "Missing Operand" Error
  JP C,FIN_DBL          ;IF NUMERIC, INTERPRET CONSTANT              If numeric type, create FP number
  CALL ISLETTER_A       ;VARIABLE NAME?                              See if a letter
  JP NC,EVAL_VARIABLE   ;AN ALPHABETIC CHARACTER MEANS YES           Letter - Find variable
  CP TK_PLUS			;IGNORE "+"
  JP Z,OPRND			; ..skip it, we will look the digits
  CP '.'
  JP Z,FIN_DBL          ; If numeric, create FP number
  CP TK_MINUS           ;NEGATION?
  JP Z,MINUS            ; Yes - deal with minus sign
  CP '"'                ;STRING CONSTANT?
  JP Z,QTSTR			;IF SO BUILD A DESCRIPTOR IN A TEMPORARY DESCRIPTOR LOCATION
                        ;AND PUT A POINTER TO THE DESCRIPTOR IN FACLO.
  CP TK_NOT             ;CHECK FOR "NOT" OPERATOR
  JP Z,NOT
  CP TK_ERR             ;'ERR' token ?
  JP NZ,NTERC           ;NO, TRY OTHER POSSIBILITIES

; ERR Function
ERR:
  RST CHRGTB            ;GRAB FOLLOWING CHAR IS IT A DISK ERROR CALL?
  LD A,(ERR_CODE)       ;GET THE ERROR CODE. "CPI OVER NEXT BYTE
  PUSH HL               ;SAVE TEXT POINTER
  CALL PASSA            ;RETURN THE VALUE
  POP HL                ;RESTORE TEXT POINTER
  RET                   ;ALL DONE.

; This entry point is used by the routine at OPRND.
NTERC:
  CP TK_ERL             ;ERROR LINE NUMBER VARIABLE
  JP NZ,NTERL           ;NO, TRY MORE THINGS.

; ERRL Function
ERL:
  RST CHRGTB            ;GET FOLLOWING CHARACTER
  PUSH HL               ;SAVE TEXT POINTER
  LD HL,(ERRLIN)        ;GET THE OFFENDING LINE #
  CALL DBL_ABS_0        ;FLOAT 2 BYTE UNSINGED INT
  POP HL                ;RESTORE TEXT POINTER
  RET                   ;RETURN
  
; This entry point is used by the routine at ERR.
NTERL:
  CP TK_TIME_S
  JP Z,TIME_S_FN
  CP TK_DATE_S
  JP Z,DATE_S_FN
  CP TK_DAY_S
  JP Z,DAY_S_FN
  CP TK_MAX
  JP Z,MAX_FN
  CP TK_HIMEM
  JP Z,_HIMEM

  CP TK_VARPTR          ;VARPTR CALL?
  JP NZ,NTVARP          ;NO

; VARPTR Function
VARPTR:
  RST CHRGTB            ;EAT CHAR AFTER
  RST SYNCHR            ;EAT LEFT PAREN
  DEFB '('              
  CP '#'                ;WANT POINTER TO FILE?
  JP NZ,NVRFIL          ;NO, MUST BE VARIABLE

; VARPTR(#buffer) Function
VARPTR_BUF:
  CALL FNDNUM           ;READ FILE #
  PUSH HL               ;SAVE TEXT PTR
  CALL GETPTR           ;GET PTR TO FILE
  EX DE,HL
  POP HL                ;RESTORE TEXT PTR
  JP VARPTR_0

; VARPTR(variable) Function
;
; Used by the routine at VARPTR.
NVRFIL:
  CALL PTRGET           ;GET ADDRESS OF VARIABLE
  
; This entry point is used by the routine at VARPTR_BUF.
VARPTR_0:
  RST SYNCHR
  DEFB ')'              ;EAT RIGHT PAREN
  PUSH HL               ;SAVE TEXT POINTER
  EX DE,HL              ;GET VALUE TO RETURN IN [H,L]
  LD A,H                ;MAKE SURE NOT UNDEFINED VAR
  OR L                  ;SET CC'S. ZERO IF UNDEF
  JP Z,FC_ERR           ;ALL OVER IF UNDEF (DONT WANT USER POKING INTO ZERO IF HE'S TOO LAZY TO CHECK
  CALL MAKINT           ;MAKE IT AN INT
  POP HL                ;RESTORE TEXT POINTER
  RET

; This entry point is used by the routine at ERL.
NTVARP:
  CP TK_INSTR           ;IS IT THE INSTR FUNCTION??
  JP Z,INSTR            ;DISPATCH
  CP TK_INKEY_S         ;INKEY$ FUNCTION?
  JP Z,INKEY_S          ;GO DO IT
  CP TK_STRING_S        ;STRING FUNCTION?
  JP Z,STRING_S         ;YES, GO DO IT
  CP TK_INPUT           ;FIXED LENGTH INPUT?
  JP Z,INPUT_S          ;YES
  CP TK_CSRLIN
  JP Z,CSRLIN
  CP TK_DSKI_S
  JP Z,DSKI_S
  SUB TK_MINOR+1		; '<' +1  (higher opr code)
  JP NC,ISFUN           ; ..Is the token even bigger than the operator codes ?
                        ; Then probably.. (A FUNCTION CALL is PRECEDED BY $FF, 377 OCTAL)
                        ; (on MSX and CP/M: NUMBERED CHARACTERS ALLOWED SO THERE IS NO NEED TO CHECK THE UPPER BOUND)

; End of expression.  Look for ')'.
; ONLY POSSIBILITY LEFT IS A FORMULA IN PARENTHESES
;
; This entry point is used by the routine at UCASE.
EVLPAR:
  CALL OPNPAR       ; Evaluate expression in "()", RECURSIVELY EVALUATE THE FORMULA
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  RET


; '-', deal with minus sign

; This entry point is used by the routine at OPRND.
MINUS:
  LD D,$7D			; "-" precedence                   ;A PRECEDENCE BELOW ^
  CALL EVAL_1		; Evaluate until prec' break       ;BUT ABOVE ALL ELSE
  LD HL,(NXTOPR)	; Get next operator address        ;SO ^ GREATER THAN UNARY MINUS
  PUSH HL			; Save next operator address       ;GET TEXT POINTER
  CALL INVSGN		; Negate value


; Routine at 4056
; FUNCTIONS THAT DON'T RETURN STRING VALUES COME BACK HERE (POP HL / RET)
RETNUM:
  POP HL			; Restore next operator address
  RET

; Variable evaluation routine
;
; Used by the routine at OPRND.
; EVAL_VARIABLE (a.k.a. CONVAR)
EVAL_VARIABLE:
  CALL GETVAR           ;GET A POINTER TO THE VARIABLE IN [D,E]
; Routine at 4061
COMPTR:
  PUSH HL               ;SAVE THE TEXT POINTER
  EX DE,HL              ;PUT THE POINTER TO THE VARIABLE VALUE INTO [H,L]. IN THE CASE OF A STRING
                        ;THIS IS A POINTER TO A DESCRIPTOR AND NOT AN ACTUAL VALUE
  LD (FACLOW),HL        ;IN CASE IT'S STRING STORE THE POINTER TO THE DESCRIPTOR IN FACLO.
  RST GETYPR            ;Get the number type (FAC).   FOR STRINGS WE JUST LEAVE
  CALL NZ,FP_HL2DE      ;A POINTER IN THE FAC THE FAC USING [H,L] AS THE POINTER.   (CALL if not string type)
  POP HL                ;RESTORE THE TEXT POINTER
  RET

; Get char from (HL) and make upper case
;
; Used by the routines at SETSER, __DAY_S, FNAME, DSKI_S, FIND_TEXT and
; LOAD_BA_LBL.
MAKUPL:
  LD A,(HL)             ;GET CHAR FROM MEMORY

; Make char in 'A' upper case
;
; Used by the routines at __DAY_S, TEL_SET_STAT, TEL_BYE, FIND_TEXT, IS_CRLF and
; CHGET_UCASE.
UCASE:
  CP 'a'            ;IS IT LOWER CASE RANGE
  RET C             ;LESS
  CP 'z'+1          ;GREATER
  RET NC            ;TEST
  AND $5F           ;MAKE UPPER CASE
  RET               ;DONE

; Used by the routine at OPRND.
ISFUN:
  LD B,$00          ; Get address of function
  RLCA              ; Double function offset                 ;MULTIPLY BY 2
  LD C,A            ; BC = Offset in function table
  PUSH BC           ; Save adjusted token value              ;SAVE THE FUNCTION # ON THE STACK
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,C            ; Get adjusted token value               ;LOOK AT FUNCTION #
  CP 2*TK_SPACE_S-2*ONEFUN+1 ; Adj' LEFT$,RIGHT$ or MID$ ?
  JP C,OKNORM       ; No - Do function

;
; MOST FUNCTIONS TAKE A SINGLE ARGUMENT.
; THE RETURN ADDRESS OF THESE FUNCTIONS IS A SMALL ROUTINE
; THAT CHECKS TO MAKE SURE VALTYP IS 0 (NUMERIC) AND POPS OFF
; THE TEXT POINTER. SO NORMAL FUNCTIONS THAT RETURN STRING RESULTS (I.E. CHR$)
; MUST POP OFF THE RETURN ADDRESS OF LABBCK, AND POP OFF THE
; TEXT POINTER AND THEN RETURN TO FRMEVL.
;
; THE SO CALLED "FUNNY" FUNCTIONS CAN TAKE MORE THAN ONE ARGUMENT.
; THE FIRST OF WHICH MUST BE STRING AND THE SECOND OF WHICH
; MUST BE A NUMBER BETWEEN 0 AND 256. THE TEXT POINTER IS
; PASSED TO THESE FUNCTIONS SO ADDITIONAL ARGUMENTS
; CAN BE READ. THE TEXT POINTER IS PASSED IN [D,E].
; THE CLOSE PARENTHESIS MUST BE CHECKED AND RETURN IS DIRECTLY
; TO FRMEVL WITH [H,L] SETUP AS THE TEXT POINTER POINTING BEYOND THE ")".
; THE POINTER TO THE DESCRIPTOR OF THE STRING ARGUMENT
; IS STORED ON THE STACK UNDERNEATH THE VALUE OF THE INTEGER ARGUMENT (2 BYTES)
;
; FIRST ARGUMENT ALWAYS STRING -- SECOND INTEGER
;
  CALL OPNPAR       ; Evaluate expression  (X,...             ;EAT OPEN PAREN AND FIRST ARG
  RST SYNCHR 		; Make sure "," follows
  DEFB ','                                                    ;TWO ARGS SO COMMA MUST DELIMIT
  CALL TSTSTR       ; Make sure it's a string                 ;MAKE SURE THE FIRST ONE WAS STRING
  EX DE,HL          ; Save code string address                ;[D,E]=TXTPTR
  LD HL,(FACLOW)    ; Get address of string                   ;GET PTR AT STRING DESCRIPTOR
  EX (SP),HL        ; Save address of string                  ;GET FUNCTION # <> SAVE THE STRING PTR
  PUSH HL           ; Save adjusted token value               ;PUT THE FUNCTION # ON
  EX DE,HL          ; Restore code string address             ;[H,L]=TXTPTR
  CALL GETINT       ; Get integer 0-255                       ;[E]=VALUE OF FORMULA
  EX DE,HL          ; Save code string address                ;TEXT POINTER INTO [D,E] <> [H,L]=INT VALUE OF SECOND ARGUMENT
  EX (SP),HL        ; Save integer,HL = adj' token            ;SAVE INT VALUE OF SECOND ARG <> [H,L]=FUNCTION NUMBER
  JP GOFUNC         ; Jump to string function                 ;DISPATCH TO FUNCTION

OKNORM:
  CALL EVLPAR       ; Evaluate expression                     ;CHECK OUT THE ARGUMENT AND MAKE SURE ITS FOLLOWED BY ")"
  EX (SP),HL        ; HL = Adjusted token value               ;[H,L]=FUNCTION # AND SAVE TEXT POINTER
;
; CHECK IF SPECIAL COERCION MUST BE DONE FOR ONE OF THE TRANSCENDENTAL
; FUNCTIONS (RND, SQR, COS, SIN, TAN, ATN, LOG, AND EXP)
; THESE FUNCTIONS DO NOT LOOK AT VALTYP, BUT RATHER ASSUME THE
; ARGUMENT PASSED IN THE FAC IS SINGLE PRECISION, SO FRCSNG
; MUST BE CALLED BEFORE DISPATCHING TO THEM.
;
  LD A,L                 ;[A]=FUNCTION NUMBER
  CP 2*(TK_SQR-ONEFUN)   ;LESS THAN SQUARE ROOT?        ; Adj' SGN, INT or ABS ?
  JP C,NOTFRF            ;DON'T FORCE THE ARGUMENT
  CP 2*(TK_ATN-ONEFUN)+1 ;BIGGER THAN ARC-TANGENT?      ; Adj' ABS, SQR, RND, SIN, LOG, EXP, COS, TAN or ATN ?
  JP NC,NOTFRF           ;DON'T FORCE THE ARGUMENT
  RST GETYPR
  PUSH HL                ;SAVE THE FUNCTION NUMBER
  CALL C,__CDBL          ;IF NOT, FORCE FAC TO DOUBLE-PRECISION
  POP HL                 ;RESTORE THE FUNCTION NUMBER
NOTFRF:
  LD DE,RETNUM        ; Return number from function       ;RETURN ADDRESS
  PUSH DE             ; Save on stack                     ;MAKE THEM REALLY COME BACK
GOFUNC:
  LD BC,FNCTAB_FN     ; Function routine addresses        ;FUNCTION DISPATCH TABLE
; This entry point is used by the routine at PASSA.
DISPAT:
  ADD HL,BC           ; Point to right address            ;ADD ON THE OFFSET
  LD C,(HL)           ; Get LSB of address                ;FASTER THAN PUSHM
  INC HL              ;
  LD H,(HL)           ; Get MSB of address
  LD L,C              ; Address to HL
  JP (HL)             ; Jump to function                  ;GO PERFORM THE FUNCTION
 
; THE FOLLOWING ROUTINE IS CALLED FROM FIN IN F4
; TO SCAN LEADING SIGNS FOR NUMBERS. IT WAS MOVED
; TO F3 TO ELIMINATE BYTE EXTERNALS
;
; This entry point is used by the routine at _ASCTFP.
; test '+', '-'..
SGNEXP:
  DEC D         ; Dee to flag negative exponent          ;SET SIGN OF EXPONENT FLAG
  CP TK_MINUS   ;  .."-" token ?                         ;NEGATIVE EXPONENT?
  RET Z         ; Yes - Return
  CP '-'        ; "-" ASCII ?
  RET Z         ; Yes - Return
  INC D         ; Inc to flag positive exponent          ;NO, RESET FLAG
  CP '+'        ; "+" ASCII ?
  RET Z         ; Yes - Return
  CP TK_PLUS    ;  .."+" token ?                         ;IGNORE "+"
  RET Z         ; Yes - Return

; Routine at 4165
DCXH:
  DEC HL        ; DEC 'cos GETCHR INCs                   ;CHECK IF LAST CHARACTER WAS A DIGIT
  RET           ; Return "NZ"                            ;RETURN WITH NON-ZERO SET
  
; Routine at 4167
DOCMP:
  INC A                   ;SETUP BITS
  ADC A,A                 ;4=LESS 2=EQUAL 1=GREATER
  POP BC                  ;WHAT DID HE WANT?
  AND B                   ;ANY BITS MATCH?
  ADD A,$FF               ;MAP 0 TO 0
  SBC A,A                 ;AND ALL OTHERS TO 377
  CALL INT_RESULT_A       ;CONVERT [A] TO AN INTEGER SIGNED
  JP NOT_0                ;RETURN FROM OPERATOR APPLICATION PLACE SO THE TEXT POINTER
                          ;WILL GET SET UP TO WHAT IT WAS WHEN LPOPER RETURNED.

; Routine at 4180
;
; Used by the routine at OPRND.
; Evaluate 'NOT'
NOT:
  LD D,$5A              ; Precedence value for "NOT"         ;"NOT" HAS PRECEDENCE 90, SO FORMULA EVALUATION
  CALL EVAL_1           ; Eval until precedence break        ;IS ENTERED WITH A DUMMY ENTRY OF 90 ON THE STACK
  CALL __CINT           ; Get integer -32768 - 32767         ;COERCE THE ARGUMENT TO INTEGER
  LD A,L                ; Get LSB                            ;COMPLEMENT [H,L]
  CPL                   ; Invert LSB
  LD L,A                ; Save "NOT" of LSB
  LD A,H                ; Get MSB
  CPL                   ; Invert MSB
  LD H,A                ; Set "NOT" of MSB
  LD (FACLOW),HL        ; Save AC as current                 ;UPDATE THE FAC
  POP BC                ; Clean up stack                     ;FRMEVL, AFTER SEEING THE PRECEDENCE OF 90 THINKS IT IS 
                                                             ;APPLYING AN OPERATOR SO IT HAS THE TEXT POINTER IN TEMP2 SO
; This entry point is used by the routine at DOCMP.
NOT_0:
  JP EVAL3              ; Continue evaluation                ;RETURN TO REFETCH IT

; RST 28H routine.  Return the number type (FAC)
;
; Used by the routine at GETYPR.
_GETYPR:
  LD A,(VALTYP)
  CP $08	; set M,PO.. flags
;
; CONTINUATION OF GETYPE RST
;
  DEC A
  DEC A
  DEC A		; Z=String
  RET

;
; DANDOR APPLIES THE "AND" AND "OR" OPERATORS
; AND SHOULD BE USED TO IMPLEMENT ALL LOGICAL OPERATORS.
; WHENEVER AN OPERATOR IS APPLIED, ITS PRECEDENCE IS IN [B].
; THIS FACT IS USED TO DISTINGUISH BETWEEN "AND" AND "OR".
; THE RIGHT HAND ARGUMENT IS COERCED TO INTEGER, JUST AS
; THE LEFT HAND ONE WAS WHEN IT WAS PUSHED ON THE STACK.
;
; Routine at 4210
DANDOR:
  LD A,B               ;SAVE THE PRECEDENCE "OR"=70
  PUSH AF
  CALL __CINT          ;COERCE RIGHT HAND ARGUMENT TO INTEGER
  POP AF               ;GET BACK THE PRECEDENCE TO DISTINGUISH "AND" AND "OR"
  POP DE               ;POP OFF THE LEFT HAND ARGUMENT
  CP $7A               ;IS THE OPERATOR "MOD"?    (as in PRITAB)
  JP Z,IMOD            ;IF SO, USE MONTE'S SPECIAL ROUTINE
  CP $7B               ;IS THE OPERATOR "IDIV"?   (as in PRITAB)
  JP Z,INT_DIV         ;LET MONTE HANDLE IT
  LD BC,GIVINT         ;PLACE TO RETURN WHEN DONE
  PUSH BC              ;SAVE ON STACK
  CP $46               ;SET ZERO FOR "OR"
  JP NZ,NOTOR

OR:
  LD A,E               ;SETUP LOW IN [A]
  OR L
  LD L,A
  LD A,H
  OR D
  RET                  ;RETURN THE INTEGER [A,L]

NOTOR:
  CP $50               ;AND?
  JP NZ,NOTAND
  
AND:
  LD A,E
  AND L
  LD L,A
  LD A,H
  AND D
  RET
  
NOTAND:
  CP $3C               ;XOR?
  JP NZ,NOTXOR         ;NO

XOR:
  LD A,E
  XOR L
  LD L,A
  LD A,H
  XOR D
  RET
  
NOTXOR:
  CP $32               ;EQV?
  JP NZ,IMP            ;NO

EQV:
  LD A,E               ;LOW PART
  XOR L
  CPL
  LD L,A
  LD A,H
  XOR D
  CPL
  RET

; 'IMP' expression
;
;FOR "IMP" USE A IMP B = NOT(A AND NOT(B))
IMP:
  LD A,L               ;MUST BE "IMP"
  CPL
  AND E
  CPL
  LD L,A
  LD A,H
  CPL
  AND D
  CPL
  RET

;
; THIS ROUTINE SUBTRACTS [D,E] FROM [H,L]
; AND FLOATS THE RESULT LEAVING IT IN FAC.
;
; This entry point is used by the routine at __FRE.
GIVDBL:
  LD A,L               ;[H,L]=[H,L]-[D,E]
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A               ;SAVE HIGH BYTE IN [H]
  JP DBL_ABS_0         ;FLOAT 2 BYTE UNSIGNED INT

; LPOS Function
__LPOS:
  LD A,(LPTPOS)
  JP PASSA             ;SEE WHERE WE ARE

; POS Function
__POS:
  LD A,(TTYPOS)        ;GET TELETYPE POSITION, SEE WHERE WE ARE

; Load the integer in the A register into FAC1.
;
; Used by the routines at ERR, __LPOS, __INP, __PEEK and __VAL.
PASSA:
  LD L,A               ;MAKE [A] AN UNSIGNED INTEGER
  XOR A

; Routine at 4307
GIVINT:
  LD H,A
  JP MAKINT

; This entry point is used by the routine at __LET.
; a.k.a. DOCNVF (=force type conversion)
CHKTYP:
  PUSH HL              ;SAVE THE TEXT POINTER
  AND $07              ;SETUP DISPATCH TO FORCE FORMULA TYPE 
                       ;TO CONFORM TO THE VARIABLE ITS BEING ASSIGNED TO
  LD HL,TYPE_OPR       ;TABLE OF FORCE ROUTINES
  LD C,A               ;[B,C]=TWO BYTE OFFSET
  LD B,$00
  ADD HL,BC
  CALL DISPAT          ;DISPATCH
  POP HL               ;GET BACK THE TEXT POINTER
  RET

;
; SUBROUTINE TO SEE IF WE ARE IN DIRECT MODE AND COMPLAIN IF SO
;
; Check for a running program (Z if so).  If a program is not running, generate
; an Illegal Direct (ID) error.
;
; Used by the routines at __LINE and __INPUT.
IDTEST:
  PUSH HL             ; Save code string address                   ;SAVE THEIR [H,L]
  LD HL,(CURLIN)      ; Get current line number                    ;SEE WHAT THE CURRENT LINE IS
  INC HL              ; -1 means direct statement                  ;DIRECT IS 65,535 SO NOW 0
  LD A,H
  OR L                                                             ;IS IT ZERO NOW?
  POP HL              ; Restore code string address
  RET NZ              ; Return if in program                       ;RETURN IF NOT
                                                                   ;"ILLEGAL DIRECT" ERROR
; ID error: illegal immediate instruction
ID_ERR:
  LD E,$0C            ; Err $0C - "Illegal direct" (ID_ERROR)
  JP ERROR

; This entry point is used by the routine at STATEMENT.
NOT_KEYWORD:
  CP $7E
  JP NZ,SN_ERR
  INC HL
  JP LHSMID
  JP SN_ERR

;
; THE FOLLOWING FUNCTIONS ALLOW THE 
; USER FULL ACCESS TO THE ALTAIR I/O PORTS
; INP(CHANNEL#) RETURNS AN INTEGER WHICH IS THE STATUS
; OF THE CHANNEL. OUT CHANNEL#,VALUE PUTS OUT THE INTEGER
; VALUE ON CHANNEL #. IT IS A STATEMENT, NOT A FUNCTION.
;
; INP Function
__INP:
  CALL CONINT         ;GET INTEGER CHANNEL #
  LD (INPORT),A
  CALL _INP
  JP PASSA

; Routine at 4364
__OUT:
  CALL SETIO
  JP _OUT

; Get subscript
;
; Used by the routines at STEP and LINE_GFX.
FPSINT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

; Same as 1112H except that the evalutation starts at HL-1
;
; Used by the routine at DEFCON.
FPSINT_0:
  CALL EVAL          ;EVALUATE A FORMULA

; Get integer variable to DE, error if negative
;
; Used by the routine at CONINT.
DEPINT:
  PUSH HL            ;SAVE THE TEXT POINTER
  CALL __CINT        ;CONVERT THE FORMULA TO AN INTEGER IN [H,L]
  EX DE,HL           ;PUT THE INTEGER INTO [D,E]
  POP HL             ;RETSORE THE TEXT POINTER
  LD A,D             ;SET THE CONDITION CODES ON THE HIGH ORDER
  OR A
  RET

; This entry point is used by the routine at __OUT.
SETIO:
  CALL GETINT                 ; Get integer 0-255
  LD (INPORT),A
  LD (OTPORT),A
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JP GETINT

; Load 'A' with the next number in BASIC program
;
; Used by the routines at TAB, VARPTR_BUF and L4F2E.
FNDNUM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.

; Get a number to 'A'
;
; Used by the routines at ON_ERROR, __ERROR, UCASE, DEPINT, __POKE, POWER_ON,
; __DATE_S, __MDM, OUTS_B_CHARS, LINE_GFX, __SOUND, __CALL, __SCREEN, INSTR,
; GETPTR, __OPEN, __CLOSE, INPUT_S, TEL_SET_STAT, TEL_UPLD, TXT_CTL_Y and __MAX.
; Get integer 0-255
GETINT:
  CALL EVAL         ;EVALUATE A FORMULA

; Convert tmp string to int in A register
;
; Used by the routines at __INP, __CHR_S, STRING_S, __SPACE_S, INSTR and FNAME.
CONINT:
  CALL DEPINT       ;CONVERT THE FAC TO AN INTEGER IN [D,E]
  JP NZ,FC_ERR      ;WASN'T ERROR (Err $05 - "Illegal function call")
  DEC HL            ;ACTUALLY FUNCTIONS CAN GET HERE
                    ;WITH BAD [H,L] BUT NOT SERIOUS
                    ;SET CONDITION CODES ON TERMINATOR
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,E            ;RETURN THE RESULT IN [A] AND [E]
  RET

; Routine at 4411
__LLIST:                ;PRTFLG=1 FOR REGULAR LIST
  LD A,$01              ;GET NON ZERO VALUE
  LD (PRTFLG),A         ;SAVE IN I/O FLAG (END OF LPT)

; Routine at 4416
;
; Used by the routines at __SAVE and __EDIT.
__LIST:
  POP BC                ;GET RID OF NEWSTT RETURN ADDR
  CALL LNUM_RANGE       ;SCAN LINE RANGE
  PUSH BC               ;SAVE POINTER TO 1ST LINE
  LD H,B
  LD L,C
  LD (LBLIST),HL
__LIST_0:
  LD HL,$FFFF           ;DONT ALLOW ^C TO CHANGE
  LD (CURLIN),HL		;CONTINUE PARAMETERS:  Set interpreter in 'DIRECT' (immediate) mode
  POP HL                ;GET POINTER TO LINE
  LD (LBEDIT),HL        ;GET MAX LINE # OFF STACK
  POP DE                ;[B,C]=THE LINK POINTING TO THE NEXT LINE
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,B                ;SEE IF END OF CHAIN
  OR C                  
  JP Z,__LIST_END       ;LAST LINE, STOP.  
  CALL ISFLIO           ;DON'T ALLOW ^C ON FILE OUTPUT
  CALL Z,ISCNTC         ;CHECK FOR CONTROL-C
  PUSH BC               ;SAVE LINK
  LD C,(HL)             ;PUSH THE LINE #
  INC HL
  LD B,(HL)
  INC HL
  PUSH BC
  EX (SP),HL            ;GET LINE # INTO [H,L]
  EX DE,HL              ;GET MAX LINE IN [H,L]
  RST CPDEHL            ;PAST LAST LINE IN RANGE?
  POP BC                ;TEXT POINTER TO [B,C]
  JP C,__LIST_2         ;IF PAST, THEN DONE LISTING.
  EX (SP),HL            ;SAVE MAX ON BOTTOM OF STACK
  PUSH HL               ;SAVE LINK ON TOP
  PUSH BC               ;SAVE TEXT POINTER BACK
  EX DE,HL              ;GET LINE # IN [H,L]
  LD (DOT),HL           ;SAVE FOR LATER EDIT OR LIST <> AND WE WANT [H,L] ON THE STACK
  CALL NUMPRT           ;PRINT AS INT WITHOUT LEADING SPACE
  POP HL
  LD A,(HL)             ;GET BYTE FROM LINE
  CP $09                ;IS IT A TAB?
  JP Z,__LIST_1         ;THEN DONT PRINT SPACE
  LD A,' '
  RST OUTDO              ;PRINT A SPACE AFTER THE LINE #
__LIST_1:               
  CALL DETOKEN_LIST     ;UNPACK THE LINE INTO BUF
  LD HL,KBUF            ;POINT AT THE START OF THE UNPACKED CHARACTERS
  CALL LISPRT         ;PRINT THE LINE
  CALL OUTDO_CRLF       ;PRINT CRLF
  JP __LIST_0           ;GO BACK FOR NEXT LINE

__LIST_2:
  POP BC

__LIST_END:
  LD A,(EDITMODE)
  AND A
  JP NZ,__EDIT_1
  LD A,$1A		; EOF
  RST OUTDO
  JP READY

; print zero terminated string
;
; Used by the routine at __LIST.
LISPRT:
  LD A,(HL)
  OR A                  ;SET CC
  RET Z                 ;IF =0 THEN END OF LINE
  RST OUTDO              ;OUTPUT CHAR AND CHECK FOR LF
  INC HL                ;INCR POINTER
  JP LISPRT             ;PRINT NEXT CHAR
  
; This entry point is used by the routine at __LIST.
DETOKEN_LIST:
  LD BC,KBUF            ;GET START OF TEXT BUFFER
  LD D,$FF              ;GET ITS LENGTH INTO [D]
  XOR A                 ;SET ON SPECIAL CHAR FOR SPACE INSERTION
  LD (OPRTYP),A         ; a.k.a. DORES, indicates whether stored word can be crunched, etc..
  JP DETOKEN_NEXT_1     ;START HERE
  
DETOKEN_NEXT:
  INC BC                ;INCREMENT DEPOSIT PTR.
  DEC D                 ;BUMP DOWN COUNT
  RET Z                 ;IF BUFFER FULL, RETURN
DETOKEN_NEXT_1:
  LD A,(HL)             ;GET CHAR FROM BUF
  INC HL                
  OR A                  ;SET CC'S
  LD (BC),A             ;SAVE THIS CHAR
  RET Z                 ;IF END OF SOURCE BUFFER, ALL DONE.
  CP '"'                ; Not a number ?
  JP NZ,DETOKEN_NEXT_2
  LD A,(OPRTYP)
  XOR $01
  LD (OPRTYP),A
  LD A,'"'
DETOKEN_NEXT_2:
  CP ':'
  JP NZ,DETOKEN_NEXT_4
  LD A,(OPRTYP)
  RRA
  JP C,DETOKEN_NEXT_3
  RLA
  AND $FD
  LD (OPRTYP),A
DETOKEN_NEXT_3:
  LD A,':'
DETOKEN_NEXT_4:
  OR A
  JP P,DETOKEN_NEXT
  LD A,(OPRTYP)
  RRA
  JP C,DETOKEN_NEXT
  DEC HL
  RRA
  RRA
  JP NC,DETOKEN
  LD A,(HL)
  CP TK_APOSTROPHE			; TK_APOSTROPHE: COMMENT, check if line ends with the apostrophe..
  PUSH HL
  PUSH BC
  LD HL,__DETOKEN_NEXT
  PUSH HL
  RET NZ
  
  ; ..or with the ':REM' sequence..
  DEC BC
  LD A,(BC)
  CP $4D         ; 'M'
  RET NZ
  DEC BC
  LD A,(BC)
  CP $45         ; 'E'
  RET NZ
  DEC BC
  LD A,(BC)
  CP $52         ; 'R'
  RET NZ
  DEC BC
  LD A,(BC)
  CP ':'
  RET NZ
  POP AF
  POP AF
; This entry point is used by the routine at FONT.
LISPRT_6:
  POP HL
  INC D		; add 4 to line byte counter D
  INC D
  INC D
  INC D
  JP PLOOPR

__DETOKEN_NEXT:
  POP BC
  POP HL
  LD A,(HL)
LISPRT_7:
  INC HL
  JP DETOKEN_NEXT

SET_DATA_FLAG:
  LD A,(OPRTYP)	; Indicates whether stored word can be crunched
  OR $02
UPD_OPRTYP:
  LD (OPRTYP),A
  XOR A
  RET
  
SET_REM_FLAG:
  LD A,(OPRTYP)
  OR $04
  JP UPD_OPRTYP

DETOKEN:
  RLA
  JP C,LISPRT_7
  LD A,(HL)
  CP $83		; TK_DATA
  CALL Z,SET_DATA_FLAG
  CP $8E		; TK_REM
  CALL Z,SET_REM_FLAG
  
PLOOPR:
  LD A,(HL)
  INC HL
  CP $91		; TK_ELSE    ;ELSE?

IF KC85 | M10
  JP NZ,NTFNTK
  DEC BC
  INC D
NTFNTK:
ENDIF

IF M100
  CALL Z,DCXBRT           ;MOVE DEPOSIT PTR BACK OVER LEADING COLON.
ENDIF

  SUB $7F
  PUSH HL
  LD E,A
  LD HL,WORDS
DETOKEN_NEXT3:
  LD A,(HL)                 ;GET CHAR
  INC HL                    ;BUMP POINTER
  OR A
  JP P,DETOKEN_NEXT3
  DEC E
  JP NZ,DETOKEN_NEXT3
  AND $7F                   ;TURN OFF HIGH BIT
DETOKEN_NEXT4:
  LD (BC),A
  INC BC
  DEC D
  JP Z,POPAF
  LD A,(HL)
  INC HL
  OR A
  JP P,DETOKEN_NEXT4
  POP HL
  JP DETOKEN_NEXT_1
  
;
; ERASE A LINE FROM MEMORY
; [B,C]=START OF LINE BEING DELETED
; [D,E]=START OF NEXT LINE
;
; This entry point is used by the routine at PROMPT.
;
__DELETE_0:
  EX DE,HL                  ;[D,E] NOW HAVE THE POINTER TO THE LINE BEYOND THIS ONE
  LD HL,(VARTAB)            ;COMPACTIFYING TO VARTAB
MLOOP:
  LD A,(DE)
  LD (BC),A                 ;SHOVING DOWN TO ELIMINATE A LINE
  INC BC
  INC DE
  RST CPDEHL
  JP NZ,MLOOP               ;DONE COMPACTIFYING?
  LD H,B
  LD L,C
  LD (VARTAB),HL
  LD (VAREND),HL
  LD (STREND),HL
  RET

;
; NOTE: IN THE 8K PEEK ONLY ACCEPTS POSITIVE NUMBERS UP TO 32767
; POKE WILL ONLY TAKE AN ADDRESS UP TO 32767 , NO
; FUDGING ALLOWED. THE VALUE IS UNSIGNED.
; IN THE EXTENDED VERSION NEGATIVE NUMBERS CAN BE
; USED TO REFER TO LOCATIONS HIGHER THAN 32767.
; THE CORRESPONDENCE IS GIVEN BY SUBTRACTING 65536 FROM LOCATIONS
; HIGHER THAN 32767 OR BY SPECIFYING A POSITIVE NUMBER UP TO 65535.
;

; Routine at 4740
__PEEK:
  CALL GETWORD_HL           ;GET AN INTEGER IN [H,L]
  LD A,(HL)                 ;GET THE VALUE TO RETURN
  JP PASSA                  ;AND FLOAT IT

; Routine at 4747
__POKE:
  CALL GETWORD              ;READ A FORMULA
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  POP DE
  LD (DE),A
  RET

; Get a number to DE (0..65535)
;
; Used by the routines at __POKE, __SOUND, __CALL, CSAVEM and __CLEAR.
GETWORD:
  CALL EVAL
  PUSH HL
  CALL GETWORD_HL
  EX DE,HL
  POP HL
  RET

; This entry point is used by the routine at __PEEK and GETWORD.
GETWORD_HL:
  LD BC,__CINT              ;RETURN HERE
  PUSH BC                   ;SAVE ADDR
  RST GETYPR                ;SET THE CC'S ON VALTYPE
  RET M                     ;RETURN IF ALREADY INTEGER.
  RST TSTSGN
  RET M
  CALL __CSNG
  LD BC,$3245		; BCDE = 32768 (float)
  LD DE,$8076
  CALL FCOMP
  RET C
  LD BC,$6545		; BCDE = 65536 (float)
  LD DE,$6053
  CALL FCOMP
  JP NC,OV_ERR
  LD BC,$65C5		; BCDE = -65536 (float)
  LD DE,$6053
  JP FADD

; A = Character (wait if no char, FN keys are remapped)  CY if special keys
;
; Used by the routines at _INLIN, INKEY_S, INPUT_S, TEL_TERM, TEL_PREV, TEL_UPLD,
; IS_CRLF, CHGET_UCASE, WAIT_SPC, MCLEAR, TXT_CTL_N and MOVE_TEXT.
CHGET:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL CHGET_0
  JP POPALL_0

CHGET_0:
  RST $38
  DEFB HC_CHGE ; Offset: 04  (allow access to other devices than the internal keyboard)
  
  LD HL,(FNKPNT)
  INC H
  DEC H
  JP Z,CHGET_4
  LD B,(HL)
  LD A,B
  OR A
  JP Z,CHGET_1
  INC HL
  LD A,(HL)
  OR A
  JP NZ,CHGET_2
CHGET_1:
  LD H,A
CHGET_2:
  LD (FNKPNT),HL
  LD A,B
  RET
  
; HOME cursor ?
CHGET_3:
  LD A,(FNK_FLAG)
  ADD A,A
  RET C
  LD HL,$0000
  LD (PASPNT),HL
  LD A,$0D         ; CR
  LD (PASPRV),A
CHGET_4:
  LD HL,(PASPNT)
  LD A,L
  AND H
  INC A
  JP Z,CHGET_6
  PUSH HL
  LD A,(PASPRV)
  CP $0D         ; CR
  CALL Z,RESFPT
  LD HL,(HAYASHI)		; Paste buffer file
  POP DE
  ADD HL,DE
  LD A,(HL)
  LD (PASPRV),A
  LD B,A
  CP $1A		; EOF
  LD A,$00
  JP Z,CHGET_5
  CALL KEYX
  JP C,CHGET_5
  INC HL
  LD A,(HL)
  EX DE,HL
  INC HL
  LD (PASPNT),HL
  CP $1A		; EOF
  LD A,B
  SCF
  CCF
  RET NZ
CHGET_5:
  LD HL,$FFFF
  LD (PASPNT),HL
  RET

CHGET_6:
  CALL CHSNS
  JP NZ,CHGET_8
  CALL BLINK_CURS_SHOW
  LD A,$FF
  LD (POWR_FLAG),A
CHGET_7:
  CALL CHSNS
  JP Z,CHGET_7
  XOR A
  LD (POWR_FLAG),A
  CALL BLINK_CURS_HIDE
CHGET_8:
  LD HL,TMOFLG
  LD A,(HL)
  AND A
  JP NZ,POWER_DOWN
  CALL _RST75_6
  CALL KYREAD
  RET NC			; return if not special keys
  ; 8=LABEL, 9=PRINT, $0A=SH-PRINT, $0B=PASTE
  SUB $0B				
  JP Z,CHGET_3			; PASTE
  JP NC,INVALID_CH		; > $0B ?
  INC A					; $0A
  JP Z,SHIFT_PRN		; SHIFT-PRINT
  INC A					; $09
  JP Z,__LCOPY			; PRINT
  INC A					; $08 (LABEL)
  JP Z,FNBAR_TOGGLE		; LABEL
  LD E,A
  LD A,(FNK_FLAG)
  ADD A,A
  ADD A,A
  LD A,E
  RET C
  LD D,$FF
  EX DE,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL		; *16
  LD DE,FILETYPE
  ADD HL,DE
  LD A,(FNK_FLAG)
  AND A
  JP P,CHGET_9
  INC HL
  INC HL
  INC HL
  INC HL		; +4

CHGET_9:
  LD (FNKPNT),HL
  JP CHGET_0

SHIFT_PRN:
  LD HL,(SHFT_PRINT)		; SHIFT-PRINT shortcut
  JP CHGET_9

; Toggle function key label line if enabled.
;
; Used by the routine at CHGET.
FNBAR_TOGGLE:
  LD A,(LBL_LINE)
  AND A
  RET Z
  LD A,(LABEL_LN)		; Label line/8th line protect status (0=off)
  XOR $FF
; This entry point is used by the routine at __SCREEN.
FNBAR_IF_NZ:
  JP Z,ERAFNK
  JP DSPFNK

; This entry point is used by the routine at CHGET.
POWER_DOWN:
  DI
  LD (HL),$00
  LD A,(PWRINT)
  DEC HL
  LD (HL),A
  CALL TURN_OFF
  
; This entry point is used by the routine at CHGET.
INVALID_CH:
  XOR A
  RET

; This entry point is used by the routines at CHGET and CHSNS.
BLINK_CURS_SHOW:
  LD A,(CSR_STATUS)
  LD (BLINK),A
  AND A
  RET NZ
  CALL CURSON
  JP _ESC_X		; Refresh cursor

; This entry point is used by the routines at CHGET and CHSNS.
BLINK_CURS_HIDE:
  LD A,(BLINK)
  AND A
  RET NZ
  CALL CURSOFF
  JP _ESC_X		; Refresh cursor

; Z if keyboard queue is empty
;
; Used by the routines at CHGET, INKEY_S, TEL_TERM, TEL_PREV, TEL_UPLD, SHOW_TIME
; and TXT_CTL_N.
CHSNS:
  LD A,(FNKPNT+1)
  AND A
  RET NZ
  LD A,(TMOFLG)
  AND A
  RET NZ
  PUSH HL
  LD HL,(PASPNT)
  LD A,L
  AND H
  INC A
  POP HL
  RET NZ
  RST $38
  DEFB HC_CHSNS		; Offset: 06
  
  JP KEYX

;
; Check the status of the BREAK key(s).
; This entry point is used by the routines at NEWSTT, __LIST and CATALOG.
ISCNTC:
  CALL BRKCHK
  RET Z
  CP $03
  JP Z,CTL_C
  CP $13	; PAUSE ?
  RET NZ
  CALL BLINK_CURS_SHOW
ISCNTC_0:
  CALL BRKCHK
  CP $13
  JP Z,BLINK_CURS_HIDE
  CP $03
  JP NZ,ISCNTC_0
  CALL BLINK_CURS_HIDE

CTL_C:
  XOR A
  LD (KYBCNT),A		; Empty keyboard buffer
  JP __STOP

; POWER statement
__POWER:
  SUB TK_CONT
  JP Z,POWER_CONT
  CP TK_OFF-TK_CONT  ; is TK_OFF ?
  JP NZ,POWER_ON
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,TURN_OFF_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  DEFB TK_RESUME
  JP NZ,SN_ERR
  JP TURN_OFF

IF KC85 | M10
LOW_PWR_0:
  POP AF
  RET
ENDIF

; Normal TRAP (low power) interrupt routine
LOW_PWR:
  PUSH AF

IF KC85 | M10
  IN A,($D8)
  AND A
  JP M,LOW_PWR_0
ENDIF

  LD A,(POWR_FLAG)
  AND A
  LD A,$01
  LD (POWR_FLAG),A
  JP NZ,TURN_OFF_0
  POP AF

; Turn off computer
;
; Used by the routines at FNBAR_TOGGLE and __POWER.
TURN_OFF:
  DI
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,$0000
  ADD HL,SP
  LD (STAKSV),HL
  LD HL,$9C0B	; POWER ON data marker / address in RAM
  LD (ATIDSV),HL	; Address to jump to resume
; This entry point is used by the routines at __POWER and LOW_PWR.
TURN_OFF_0:
  DI

IF KC85 | M10
  CALL _RST75_6
ENDIF

  IN A,($BA)
  OR $10
  OUT ($BA),A
  HALT

; POWER CONT Statement
;
; Used by the routine at __POWER.
POWER_CONT:
  CALL POWER_ON_0
  LD (TMOFLG),A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET

; POWER ON Statement
;
; Used by the routine at __POWER.
POWER_ON:
  CALL GETINT                 ; Get integer 0-255
  CP $0A		; LF
  JP C,FC_ERR
; This entry point is used by the routine at POWER_CONT.
POWER_ON_0:
  LD (PWRINT),A
  LD (TIMINT),A
  RET

; Output character to printer without tab expansions, uses LPT_VECT
;
; Used by the routines at __LCOPY and OUTC_TABEXP.
LPT_OUT:
  RST $38
  DEFB HC_LPTO		; Offset: 10 / (12 on KC)
  
  CALL PRINTR

IF M100
  JP NC,LPT_BREAK
  XOR A
  LD (LPT_FLAG),A
  JP IO_ERR
LPT_BREAK:
ENDIF

  PUSH AF

IF M100
  LD A,$FF
  LD (LPT_FLAG),A
ENDIF

  CALL _RST75_6
  POP AF

IF KC85 | M10
  RET NC
  XOR A
  LD (LPTPOS),A
  JP IO_ERR
ENDIF

IF M100
  RET
ENDIF


; Start tape and load tape header.  If an error or Shift Break pressed,
; generate I/O error
;
; Used by the routine at CAS_OPNI_CO.
HEADER:
  CALL CTON
  CALL SYNCR
  RET NC
; This entry point is used by the routines at CASIN, CSOUT, CAS_INPUT,
; LOAD_RECORD, CLOADM and CAS_OPNI_CO.
CAS_ERR_EXIT:
  CALL CTOFF

; Generate I/O error
;
; Used by the routines at LPT_OUT, COM_OPN and COM_INPUT.
IO_ERR:
  LD E,$12
  JP ERROR

; This entry point is used by the routine at CAS_OPNO_CO.
IONTERC:
  CALL CTON
  LD BC,$0000
IO_ERR_1:
  DEC BC
  LD A,B
  OR C
  JP NZ,IO_ERR_1
  JP SYNCW

; Cassette motor ON
;
; Used by the routines at HEADER and IO_ERR.
CTON:
  DI
  defb $11		; LD DE,NN to skip the next 2 bytes

; Cassette motor OFF
;
; Used by the routines at HEADER, CAS_INPUT, __CLOAD, LOAD_RECORD, CLOADM,
; LDIR_B, CAS_OPNO_CO and CAS_OPNI_CO.
CTOFF:
  EI
  LD E,$00
  JP DATAR_1

; Read char from cassette: C=current chksum (will be updated), A=char
;
; Used by the routines at CAS_INPUT, LOAD_RECORD, LDIR_B and CAS_OPNI_CO.
CASIN:
  PUSH DE
  PUSH HL
  PUSH BC
  CALL DATAR
  JP C,CAS_ERR_EXIT
  LD A,D
  POP BC
  ADD A,C
  LD C,A
  LD A,D
  POP HL
  POP DE
  RET

; Send char to cassette: C=current chksum (will be updated), A=char
;
; Used by the routines at CAS_INPUT, SAVE_BUFFER and CAS_OPNO_CO.
CSOUT:

IF M100
  PUSH DE
  PUSH HL
ENDIF

IF KC85 | M10
  PUSH HL
  PUSH DE
ENDIF

  LD D,A
  ADD A,C
  LD C,A
  PUSH BC
  LD A,D
  CALL DATAW
  JP C,CAS_ERR_EXIT

IF M100
  POP BC
  POP HL
  POP DE
  RET
ENDIF

IF KC85 | M10
  JP POPALL_0
ENDIF



; LCD Device control block
LCD_CTL:
  DEFW LCDLPT_OPN
  DEFW _CLOSE
  DEFW LCD_OUTPUT

; LCD and LPT file open routine
LCDLPT_OPN:
  LD A,$02
  CP E					; Check current device number
  JP NZ,NM_ERR			; NM error: bad file name

; This entry point is used by the routines at RAM_OPN, CAS_OPN and COM_OPN.
REDIRECT_IO:
  LD (PTRFIL),HL
  LD (HL),E
  POP AF
  POP HL
  RET

; LCD file output routine
LCD_OUTPUT:
  POP AF
  PUSH AF
  CALL OUTC_SUB_0
; This entry point is used by the routines at CAS_OUTPUT, LPT_OUTPUT and
; COM_OUTPUT.
LCD_OUTPUT_0:
  CALL _RST75_6

; POP all registers.
;
; Used by the routines at OUTC_SUB and BOOT.
POPALL:
  POP AF
; This entry point is used by the routines at CHGET, LINE_GFX and CARDET.
POPALL_0:
  POP BC
  POP DE
  POP HL
  RET


; CRT device control block
CRT_CTL:
  DEFW CRT_OPN
  DEFW _CLOSE
  DEFW CRT_OUTPUT

; Routine at 5368
CRT_OPN:
  RST $38
  DEFB HC_TVOPN		; Offset: 64

; Routine at 5370
CRT_OUTPUT:
  RST $38
  DEFB HC_TVOUT		; Offset: 68

; RAM Device control block
RAM_CTL:
  DEFW RAM_OPN
  DEFW RAM_CLS
  DEFW RAM_OUTPUT
  DEFW RAM_INPUT
  DEFW RAM_UNGETC


; RAM file open routine
RAM_OPN:
  PUSH HL
  PUSH DE
  INC HL
  INC HL
  PUSH HL
  LD A,E					; Get current device number
  CP $01
  JP Z,RAM_OPN_3
  CP $08
  JP Z,RAM_OPN_4
RAM_OPN_0:
  CALL MAKTXT
  JP C,RAM_OPN_6
  PUSH DE
  CALL __EOF_3
  POP DE
RAM_OPN_1:
  LD BC,$0000
RAM_OPN_2:
  POP HL
  LD A,(DE)
  AND $02
  JP NZ,AO_ERR
  LD A,(DE)
  OR $02
  LD (DE),A
  INC DE
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  INC HL
  INC HL
  LD (HL),$00
  INC HL
  LD (HL),C
  INC HL
  LD (HL),B
  POP DE
  POP HL
  JP REDIRECT_IO

RAM_OPN_3:
  LD A,(EDITMODE)
  AND A
  LD HL,SUZUKI+21
  CALL Z,FINDCO_0
  JP Z,FF_ERR
  EX DE,HL
  CALL GET_RAM_PTR
  XOR A
  LD (HL),A
  LD L,A
  LD H,A
  LD (RAM_FILES),HL
  JP RAM_OPN_1

RAM_OPN_4:
  POP HL
  POP DE
  LD E,$02
  PUSH DE
  PUSH HL
  CALL RESFPT
  CALL FINDCO_0
  JP Z,RAM_OPN_0
  LD E,L
  LD D,H
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD BC,$FFFF
RAM_OPN_5:
  LD A,(HL)
  INC HL
  INC BC
  CP $1A		; EOF
  JP NZ,RAM_OPN_5
  JP RAM_OPN_2
RAM_OPN_6:
  LD A,(DE)
  AND $02
  JP NZ,AO_ERR
  EX DE,HL
  CALL KILLASC+1
  JP RAM_OPN_0

; RAM file close routine
RAM_CLS:
  PUSH HL
  CALL RAM_CLS_0
  POP HL
  CALL CLOSE_DEVICE
  CALL NZ,RAM_INPUT_2
  CALL GET_RAM_PTR
  LD (HL),$00
  JP _CLOSE
  
; This entry point is used by the routine at RAM_INPUT.
RAM_CLS_0:
  INC HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  DEC HL
  LD A,(HL)
  AND $FD
  LD (HL),A
  RET

; RAM file output routine
RAM_OUTPUT:
  POP AF
  PUSH AF
  LD BC,LCD_OUTPUT_0
  PUSH BC
  AND A
  RET Z
  CP $1A		; EOF
  RET Z
  CP $7F		; BS
  RET Z
  CALL INIT_DEV_OUTPUT
  RET NZ
  LD BC,$0100
  JP RAM_INPUT_2

; RAM file input routine
RAM_INPUT:
  EX DE,HL
  CALL GET_RAM_PTR
  CALL GET_BYTE
  EX DE,HL
  CALL INIT_INPUT
  JP NZ,RAM_INPUT_1
  EX DE,HL
  LD HL,(FILTAB+4)
  RST CPDEHL
  PUSH AF
  PUSH DE
  CALL NZ,RESFPT
  POP HL
  POP AF
  LD BC,$FFF9			; -7
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  JP NZ,RAM_INPUT_0
  PUSH DE
  EX DE,HL
  LD HL,(RAM_FILES)
  EX DE,HL
  ADD HL,DE
  POP DE
RAM_INPUT_0:
  EX DE,HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC (HL)
  INC HL
  EX DE,HL
  ADD HL,BC
  LD B,$00
  CALL LDIR_B
  EX DE,HL
  DEC H
  XOR A
RAM_INPUT_1:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  CALL GET_RAM_PTR
  LD (HL),A
  SCF
  JP RDBYT_0

; Routine at 5659
RAM_UNGETC:
  CALL GET_RAM_PTR
  JP DEV_IO_SUB

; This entry point is used by the routines at RAM_CLS and RAM_OUTPUT.
RAM_INPUT_2:
  PUSH HL
  PUSH BC
  PUSH HL
  EX DE,HL
  LD HL,(FILTAB+4)
  RST CPDEHL
  CALL NZ,RESFPT
  POP HL
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  EX DE,HL
  POP BC
  PUSH BC
  PUSH HL
  ADD HL,BC
  EX DE,HL
  LD (HL),E
  INC HL
  LD (HL),D
  LD BC,-6
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  LD A,(DE)
  LD L,A
  INC DE
  LD A,(DE)
  LD H,A
  POP BC
  ADD HL,BC
  POP BC
  PUSH HL
  PUSH BC
  CALL MAKHOL
  CALL NC,__EOF_4
  POP BC
  POP DE
  POP HL
  JP C,RAM_INPUT_4
  PUSH HL
RAM_INPUT_3:
  LD A,(HL)
  LD (DE),A
  INC DE
  INC HL
  DEC C
  JP NZ,RAM_INPUT_3
  POP DE
  LD HL,(FILTAB+4)
  RST CPDEHL
  RET Z
  JP RESFPT

RAM_INPUT_4:
  LD BC,$FFF7				; -9
  ADD HL,BC
  LD (HL),$00
  CALL RAM_CLS_0
  JP OM_ERR
  
; This entry point is used by the routines at RAM_OPN, RAM_CLS and __EOF.
GET_RAM_PTR:
  PUSH DE
  LD HL,(RAMFILE)
  LD DE,RAMPRV
  ADD HL,DE
  POP DE
  RET



; CAS Device control block
CAS_CTL:
  DEFW CAS_OPN
  DEFW CAS_CLS
  DEFW CAS_OUTPUT
  DEFW CAS_INPUT
  DEFW CAS_UNGETC

; CAS file open routine
CAS_OPN:
  PUSH HL
  PUSH DE
  LD BC,$0006
  ADD HL,BC					; char count
  XOR A
  LD (HL),A
  LD (CASPRV),A				; clear char for UNGETC
  LD A,E					; Get current device number
  CP $08
  JP Z,NM_ERR				; NM error: bad file name
  CP $01
  JP Z,CAS_OPN_1
  CALL CAS_OPNO_DO
CAS_OPN_0:
  POP DE
  POP HL
  JP REDIRECT_IO

CAS_OPN_1:
  CALL CAS_OPNI_DO
  JP CAS_OPN_0

; CAS file close routine
CAS_CLS:
  CALL CLOSE_DEVICE
  JP Z,CAS_CLS_1
  PUSH HL
  ADD HL,BC
CAS_CLS_0:
  LD (HL),$1A		; EOF
  INC HL
  INC C
  JP NZ,CAS_CLS_0
  POP HL
  CALL CAS_OUTPUT_0
CAS_CLS_1:
  XOR A
  LD (CASPRV),A
  JP _CLOSE

; CAS file output routine
CAS_OUTPUT:
  POP AF
  PUSH AF
  CALL INIT_DEV_OUTPUT
  CALL Z,CAS_OUTPUT_0
  JP LCD_OUTPUT_0

; CAS file input routine
CAS_INPUT:
  EX DE,HL
  LD HL,CASPRV
  CALL GET_BYTE
  EX DE,HL
  CALL INIT_INPUT
  JP NZ,CAS_INPUT_1
  PUSH HL
  CALL CAS_LOAD_BIN
  POP HL
  LD BC,$0000
CAS_INPUT_0:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CAS_INPUT_0
  CALL CASIN
  LD A,C
  AND A
  JP NZ,CAS_ERR_EXIT
  CALL CTOFF
  DEC H
  XOR A
  LD B,A
CAS_INPUT_1:
  LD C,A
  ADD HL,BC
  LD A,(HL)
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  LD (CASPRV),A
  SCF
  JP RDBYT_0

; Routine at 5904
CAS_UNGETC:
  LD HL,CASPRV
  JP DEV_IO_SUB
  
; This entry point is used by the routines at CAS_CLS and CAS_OUTPUT.
CAS_OUTPUT_0:
  PUSH HL
  CALL CAS_OPNO_CO_3
  POP HL
  LD BC,$0000
CAS_OUTPUT_1:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC B
  JP NZ,CAS_OUTPUT_1
  JP CAS_OPNO_CO_1

; This entry point is used by the routines at RAM_CLS and CAS_CLS.
CLOSE_DEVICE:
  LD A,(HL)
  CP $01
  RET Z
  LD BC,$0006
  ADD HL,BC					; char count
  LD A,(HL)
  LD C,A
  LD (HL),$00
  JP DEVICE_RET

; This entry point is used by the routines at RAM_OUTPUT and CAS_OUTPUT.
INIT_DEV_OUTPUT:
  LD E,A
  LD BC,$0006
  ADD HL,BC					; char count
  LD A,(HL)
  INC (HL)
  INC HL
  INC HL
  INC HL
  PUSH HL
  LD C,A
  ADD HL,BC
  LD (HL),E
  POP HL
  RET
  
; $1749: This entry point is used by the routine at RAM_INPUT.
INIT_INPUT:
  LD BC,$0006
  ADD HL,BC					; char count
  LD A,(HL)
  INC (HL)
DEVICE_RET:
  INC HL
  INC HL
  INC HL
  AND A
  RET



; $1754: LPT device control block
LPT_CTL:
  DEFW LCDLPT_OPN
  DEFW _CLOSE
  DEFW LPT_OUTPUT

; LPT file output routine
LPT_OUTPUT:
  POP AF
  PUSH AF
  CALL OUTC_TABEXP
  JP LCD_OUTPUT_0


; COM device control block
COM_CTL:
  DEFW COM_OPN
  DEFW COM_CLS
  DEFW COM_OUTPUT
  DEFW COM_INPUT
  DEFW COM_UNGETC

IF M100
; MDM file open routine
MDM_OPN:
  DEFB $F6	; OR NN
ENDIF


; COM file open routine
COM_OPN:

IF M100
  SCF
  PUSH AF
  CALL C,TEL_DISC
  POP AF
  PUSH AF
ENDIF

  PUSH HL
  PUSH DE
  LD HL,FILNAM
  CALL SETSER
  POP DE
  LD A,E				; Get current device number
  CP $08
  JP Z,NM_ERR			; NM error: bad file name
  SUB $01
  JP NZ,COM_OPN_0
  LD (COMPRV),A
COM_OPN_0:
  POP HL

IF M100
  POP AF
  JP C,REDIRECT_IO
  CALL TEL_LIFT
  JP C,IO_ERR
  LD A,$02
  CALL TMDELA
ENDIF

  JP REDIRECT_IO

; COM file close routine
;
; Used by the routine at MDM_CLS.
COM_CLS:
  CALL CLSCOM
  XOR A
  LD (COMPRV),A
  JP _CLOSE

; COM and MDM file output routine
COM_OUTPUT:
  POP AF
  PUSH AF
  CALL SD232C

IF M100
  JP LCD_OUTPUT_0
ENDIF

IF KC85 | M10
  JP NC,LCD_OUTPUT_0
  JP IO_ERR
ENDIF
  
; COM and MDM file input routine
COM_INPUT:
  LD HL,COMPRV
  CALL GET_BYTE
  CALL RV232C
  JP C,IO_ERR
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  LD (COMPRV),A
  SCF
  JP RDBYT_0

; Special COM and MDM I/O routine
COM_UNGETC:
  LD HL,COMPRV
  
; This entry point is used by the routines at RAM_INPUT and CAS_INPUT.
DEV_IO_SUB:
  LD (HL),C
  JP NOSKCR

IF M100
; $17D1: MDM device control block
MDM_CTL:
  DEFW MDM_OPN
  DEFW MDM_CLS
  DEFW COM_OUTPUT
  DEFW COM_INPUT
  DEFW COM_UNGETC

; Routine at 6107
; MDM file close routine
MDM_CLS:
  LD A,$02
  CALL TMDELA
  CALL TEL_DISC
  JP COM_CLS
ENDIF

; Set RS232 parameters, HL = zero terminated setup string, e.g. "78E1E"
;
; Used by the routines at COM_OPN, TEL_SET_STAT, TEL_LOGON, TEL_TERM and BOOT.
SETSER:

IF M100
  PUSH AF
ENDIF

  LD BC,NM_ERR			; NM error: bad file name
  PUSH BC
  
IF M100
  JP NC,SETSER_0
ENDIF

  LD A,(HL)
  SUB $31	; '1', get data bits..
  CP $09
  RET NC	; exit if > 8
  INC A
  LD D,A
  INC HL
SETSER_0:
  LD A,(HL)
  SUB $36	; '6'
  CP $03
  RET NC	; exit if < 7
; This entry point is used by the routine at WAND_CTL.
SETSER_1:
  INC A
  ADD A,A
  ADD A,A
  ADD A,A
  LD E,A
  INC HL
  CALL MAKUPL
  CP 'I'
  JP NZ,SETSER_PARITY
  LD A,E
  CP $18
  RET Z
  ADD A,$0C
  LD E,A
  AND $08
  ADD A,A
  ADD A,A
  ADD A,A
  OR $3F
  JP SETSER_STOP

SETSER_PARITY:
  CP 'E'
  LD B,$02
  JP Z,SETSER_3
  SUB 'N'
  LD B,$04
  JP Z,SETSER_3
  DEC A
  RET NZ
  LD B,A
SETSER_3:
  LD A,B
  OR E
  LD E,A
  LD A,$FF
SETSER_STOP:
  LD (COMMSK),A
  INC HL
  LD A,(HL)
  SUB '1'
  CP $02
  RET NC
  OR E
  LD E,A
  INC HL
  CALL MAKUPL
  CP $44	; 'D' .isabled
  JP Z,SETSER_5
  CP $45	; 'E' ..nabled
  RET NZ
  CALL _XONXOFF_FLG-1
SETSER_4:
  SCF
SETSER_5:
  CALL NC,_XONXOFF_FLG

IF KC85 | M10
  POP AF
  PUSH DE
IF KC85 | M10
  LD DE,STAT+4		;$F668
ENDIF
IF M100
  LD DE,STAT+6		;$F666
ENDIF
  LD B,$05
SETSER_7:
  CALL MAKUPL
  LD (DE),A
  DEC HL
  DEC DE
  DEC B
  JP NZ,SETSER_7
  POP HL
  JP INZCOM
ENDIF
  
IF M100
  POP BC
  POP AF
  PUSH AF
  PUSH DE
  DEC HL
  DEC HL
; This entry point is used by the routine at WAND_CTL.
SETSER_6:
  DEC HL
  DEC HL
  LD DE,STAT
  LD B,$05
  LD A,(HL)
  JP C,SETSER_7
  LD A,'M'
SETSER_7:
  LD (DE),A
  INC HL
  INC DE
  CALL MAKUPL
  DEC B
  JP NZ,SETSER_7
  EX DE,HL
  POP HL
  POP AF
  PUSH DE
  CALL INZCOM
  POP HL
  RET
ENDIF


; WAND device control block
; Data block at 6263
WAND_CTL:
  DEFW WND_OPN
  DEFW WND_CLS
  DEFW FC_ERR		; WAND_OUTPUT
  DEFW WND_INPUT
  DEFW WND_UNGETC

WND_OPN:
  RST $38
  DEFB HC_WAOPN		; Offset: 70

WND_CLS:
  RST $38
  DEFB HC_WACLS		; Offset: 72

WND_INPUT:
  RST $38
  DEFB HC_WAINP		; Offset: 74

WND_UNGETC:
  RST $38
  DEFB HC_WABCK		; Offset: 76


; Routine at 6281
__EOF:
  RST $38
  DEFB HC_EOF		; Offset: 38
  
  CALL FILFRM
  JP Z,CF_ERR
  CP $01
  JP NZ,NM_ERR			; NM error: bad file name
  PUSH HL
  CALL __EOF_1
  LD C,A
  SBC A,A
  CALL INT_RESULT_A
  POP HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  LD HL,COMPRV
  CP COM_DEVTYPE		; 'COM' device
  JP Z,__EOF_0
  
IF M100
  CP MDM_DEVTYPE		; 'MDM' device ?
  JP Z,__EOF_0
ENDIF

  CALL GET_RAM_PTR
  CP RAM_DEVTYPE		; 'RAM' device ?
  JP Z,__EOF_0

  LD HL,CASPRV
__EOF_0:
  LD (HL),C
  RET
  
__EOF_1:
  PUSH BC
  PUSH HL
  PUSH DE
  LD A,$06
  JP GET_DEVICE

; This entry point is used by the routines at RAM_INPUT, CAS_INPUT and COM_INPUT.
GET_BYTE:
  LD A,(HL)
  LD (HL),$00
  AND A
  RET Z
  INC SP
  INC SP
  CP $1A		; EOF
  SCF
  CCF
  JP NZ,RDBYT_0
  LD (HL),A
  SCF
  JP RDBYT_0
  
; This entry point is used by the routine at RAM_OPN.
__EOF_3:
  LD BC,$0001
; This entry point is used by the routines at RAM_INPUT and KILLASC.
__EOF_4:
  LD HL,(SAVSTK)
__EOF_5:
  LD A,(HL)
  AND A
  RET Z
  EX DE,HL
  LD HL,(STKTOP)
  EX DE,HL
  RST CPDEHL
  RET NC
  LD A,(HL)
  CP $81			; (TK_FOR ?)
  LD DE,$0007
  JP NZ,__EOF_6
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  ADD HL,BC
  EX DE,HL
  LD (HL),D
  DEC HL
  LD (HL),E
  LD DE,CPDEHL
__EOF_6:
  ADD HL,DE
  JP __EOF_5

; TIME$ function (as in Tandy docs)
;
; Used by the routine at ERL.
TIME_S_FN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL GET_DAY_0
  CALL READ_TIME
  JP TSTOPL

; Read system time, HL=8 byte area: TIME(hh:mm:ss)
;
; Used by the routines at TIME_S_FN and PRINT_TDATE.
READ_TIME:
  CALL READ_CLOCK
  LD DE,HRS_2

  CALL GET_DAY_2
  LD (HL),':'
  INC HL
  CALL GET_DAY_2
  LD (HL),':'
; This entry point is used by the routine at GET_DATE.
READ_TIME_0:
  INC HL
  JP GET_DAY_2

; DATE$ function (as in Tandy docs)
;
; Used by the routine at ERL.
DATE_S_FN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  CALL GET_DAY_0
  CALL GET_DATE
  JP TSTOPL

; Read system date, HL=8 byte area: DATE(mm/dd/yy)
;
; Used by the routines at DATE_S_FN and PRINT_TDATE.
GET_DATE:
  CALL READ_CLOCK
  
IF KC85 | M10
  LD DE,DATE_2
  CALL GET_DAY_2
  LD (HL),'/'
  INC HL
ENDIF

  LD DE,MONTH
  LD A,(DE)
  CP 10
  LD B,'0'
  JP C,GET_DATE_0
  LD B,'1'
  SUB 10
GET_DATE_0:
  LD (HL),B
  INC HL
  CALL GET_DAY_4

IF M100
  DEC DE
  LD (HL),'/'
  INC HL
  CALL GET_DAY_2
ENDIF

  LD (HL),'/'
  LD DE,YEAR_2
  JP READ_TIME_0

; DAY$ function (as in Tandy docs)
;
; Used by the routine at ERL.
DAY_S_FN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD A,$03
  CALL GET_DAY_1
  CALL GET_DAY
  JP TSTOPL

; Read system date, HL=3 byte area: DAY(ddd)
;
; Used by the routines at DAY_S_FN and PRINT_TDATE.
GET_DAY:
  CALL READ_CLOCK
  LD A,(DAY)
  LD C,A
  ADD A,A
  ADD A,C
  LD C,A
  LD B,$00
  EX DE,HL
  LD HL,WEEK_DAYS
  ADD HL,BC
  LD B,$03
  JP LDIR_B

; Message at 6520
WEEK_DAYS:
  DEFM "SunMonTueWedThuFriSat"

; Routine at 6541
; This entry point is used by the routines at TIME_S_FN and DATE_S_FN.
GET_DAY_0:
  LD A,$08
; This entry point is used by the routine at DAY_S_FN.
GET_DAY_1:
  CALL MKTMST			; Make temporary string
  LD HL,(TMPSTR)
  RET

; This entry point is used by the routines at READ_TIME and GET_DATE.
GET_DAY_2:
  CALL GET_DAY_3
GET_DAY_3:
  LD A,(DE)
; This entry point is used by the routine at GET_DATE.
GET_DAY_4:
  OR $30
  LD (HL),A
  DEC DE

; Routine at 6558
INXH:
  INC HL
  RET

; Update F923H with the time in the internal hw clock
;
; Used by the routines at READ_TIME, GET_DATE, GET_DAY and __DAY_S.
READ_CLOCK:
  PUSH HL
  LD HL,SECS
  DI
  CALL READ_CLOCK_HL
  EI
  POP HL
  RET

; TIME$ function (as in BASCK)
__TIME_S:
  CP TK_EQUAL
  JP NZ,__MDM_0
  CALL GET_TIME_ARG

; Update the internal clock chip with the values at F923H
;
; Used by the routines at __DATE_S and __DAY_S.
SET_CLOCK:
  LD HL,SECS
  DI
  CALL SET_CLOCK_HL
  EI
  POP HL
  RET

; Routine at 6589
__DATE_S:
  CALL __DAY_S_3
  JP NZ,SN_ERR

IF KC85 | M10
  LD DE,DAY
  CALL DT_DIGIT
  CP $04
  JP NC,SN_ERR
  CALL DT_DIGIT
  RST SYNCHR
  DEFB '/'
  CALL GETINT                 ; Get integer 0-255
  DEC A
  CP 12
  JP NC,SN_ERR
  INC A
  LD DE,MONTH
  LD (DE),A
  RST SYNCHR
  DEFB '/'
ENDIF

IF M100
  CALL GETINT                 ; Get integer 0-255
  DEC A
  CP 12
  JP NC,SN_ERR
  INC A
  LD DE,MONTH
  LD (DE),A
  RST SYNCHR
  DEFB '/'
  DEC DE		; DAY
  CALL DT_DIGIT
  CP $04
  JP NC,SN_ERR
  CALL DT_DIGIT
  RST SYNCHR
  DEFB '/'
ENDIF

  LD DE,CSRITP
  CALL DT_DIGIT
  CALL DT_DIGIT
  XOR A
  LD (ONDATEF),A
  JP SET_CLOCK

; Routine at 6641
__DAY_S:
  CALL __DAY_S_3
  CP $03
  JP NZ,SN_ERR
  LD DE,WEEK_DAYS
  LD C,$07
__DAY_S_0:
  PUSH HL
  LD B,$03
__DAY_S_1:
  LD A,(DE)
  PUSH DE
  CALL UCASE
  LD E,A
  CALL MAKUPL
  CP E
  POP DE
  JP NZ,__DAY_S_2
  INC DE
  INC HL
  DEC B
  JP NZ,__DAY_S_1
  POP HL
  LD A,$07
  SUB C
  LD (DAY),A
  JP SET_CLOCK

__DAY_S_2:
  INC DE
  DEC B
  JP NZ,__DAY_S_2
  POP HL
  DEC C
  JP NZ,__DAY_S_0
  JP SN_ERR

; This entry point is used by the routine at __DATE_S.
__DAY_S_3:
  RST SYNCHR
  DEFB TK_EQUAL        ; token for '='
; This entry point is used by the routine at __IPL.
__DAY_S_4:
  CALL EVAL
  EX (SP),HL
  PUSH HL
  CALL READ_CLOCK
  CALL GETSTR
  LD A,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E
  CP $08
  RET

; This entry point is used by the routines at __TIME_S and ON_TIME_S.
GET_TIME_ARG:
  CALL __DAY_S_3
  JP NZ,SN_ERR
  EX DE,HL
  POP HL
  EX (SP),HL
  PUSH HL
  EX DE,HL
  LD DE,DATE
  CALL DT_DIGIT
  
  CP $03
  JP NC,SN_ERR
  CALL DT_DIGIT
  
  RST SYNCHR
  DEFB ':'
  
  CALL L1A62
  
  RST SYNCHR
  DEFB ':'
  
L1A62:
  CALL DT_DIGIT
  CP $06
  JP NC,SN_ERR

; $1A6A, This entry point is used by the routine at __DATE_S.
DT_DIGIT:
  DEC DE
  LD A,(HL)
  INC HL
  SUB '0'
  CP $0A	; 10
  JP NC,SN_ERR
  AND $0F
  LD (DE),A
  RET
  

; Routine at 6776
__IPL:
  JP Z,ERASE_IPL
  CALL __DAY_S_4
  AND A
  JP Z,__IPL_0
  CP $0A
  JP NC,FC_ERR
  LD B,A
  EX DE,HL
  LD HL,IPL_FNAME
  CALL REV_LDIR_B
  LD (HL),$0D		; CR
  INC HL
  LD (HL),B
  POP HL
  RET

__IPL_0:
  POP HL

; Erase current IPL program (table)
;
; Used by the routines at __IPL and BOOT.
ERASE_IPL:
  XOR A
  LD (IPL_FNAME),A
  LD (IPL_FNAME+1),A
  RET

; COM and MDM Statements
__MDM:
  PUSH HL
  LD HL,TRPTBL
  JP __MDM_1

; This entry point is used by the routine at __TIME_S.
__MDM_0:
  PUSH HL
  LD HL,ON_TIME_FLG
__MDM_1:
  CALL ONOFF_OPTIONS
  
; This entry point is used by the routine at KEY_STMTS.
__MDM_2:
  POP HL
  POP AF
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NEWSTT_0

; This entry point is used by the routine at OUTS_B_CHARS.
__MDM_3:
  CALL GETINT                 ; Get integer 0-255
  DEC A
  CP $08
  JP NC,FC_ERR
  LD A,(HL)
  PUSH HL
  CALL KEY_STMTS_1
  JP __MDM_2

; KEY STOP/ON/OFF Statements
;
; Used by the routine at OUTS_B_CHARS.
KEY_STMTS:
  PUSH HL
  LD E,$08
KEY_STMTS_0:
  PUSH DE
  PUSH AF
  CALL KEY_STMTS_1
  POP AF
  POP DE
  DEC E
  JP NZ,KEY_STMTS_0
  JP __MDM_2

; This entry point is used by the routine at __MDM.
KEY_STMTS_1:
  LD D,$00
  LD HL,FNKSWI		; -2513
  ADD HL,DE
  PUSH HL
  LD HL,ON_TIME_FLG
  ADD HL,DE
  ADD HL,DE
  ADD HL,DE
  CALL ONOFF_OPTIONS
  LD A,(HL)
  AND $01
  POP HL
  LD (HL),A
  RET

; This entry point is used by the routine at __MDM.
ONOFF_OPTIONS:
  CP $97		; TK_ON, token for 'ON' keyword
  JP Z,TIME_S_ON
  CP $CB		; TK_OFF
  JP Z,TIME_S_OFF
  CP $8F		; TK_STOP
  JP Z,TIME_S_STOP
  JP SN_ERR

; This entry point is used by the routine at ON_ERROR.
ON_OPTIONS:
  CP $AD	; TK_COM
  LD BC,$0001
  RET Z
IF M100
  CP $AE	; TK_MDM
  RET Z
ENDIF
  CP $AF	; TK_KEY
  LD BC,$0208
  RET Z
  CP $AA	; TK_TIME_$ (TIME$)
  SCF
  RET NZ

; ON TIME$ Statement
ON_TIME_S:
  INC HL
  CALL GET_TIME_ARG
  LD HL,ON_TIME_TM
  LD B,$06
  CALL REV_LDIR_B
  POP HL
  DEC HL
  LD BC,$0101
  AND A
  RET

; This entry point is used by the routine at ON_ERROR.
ON_TIME_S_0:
  PUSH HL
  LD B,A
  ADD A,A
  ADD A,B
  LD L,A
  LD H,$00
  LD BC,ON_COM_ADDR		; First entry in the table for interrupt services
  ADD HL,BC
  LD (HL),E
  INC HL
  LD (HL),D
  POP HL
  RET

; RST 7.5 interrupt routine (see 3CH)
;
; Used by the routine at RST75.
_RST75:
  CALL TIMER
  PUSH HL
  PUSH DE
  PUSH BC
_RST75_0:
  PUSH AF
  LD A,$0D			; CR?
  JR NC,_RST75_0
  LD HL,CSRITP
  DEC (HL)
  JP NZ,_RST75_5
  LD (HL),$7D
  INC HL
  DEC (HL)
  JP NZ,_RST75_1
  LD (HL),12
  INC HL
  PUSH HL
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  POP HL
  CALL NZ,_RST75_6
  LD A,(HL)
  AND A
  JP Z,_RST75_1
  DEC (HL)
  JP NZ,_RST75_1
  INC HL
  LD (HL),$FF
_RST75_1:
  LD HL,CLOCK_SS1
  PUSH HL
  CALL READ_CLOCK_HL
  POP DE
  LD HL,ON_TIME_TM
  LD B,$06
_RST75_2:
  LD A,(DE)
  SUB (HL)
  JP NZ,L1B88  
  INC DE
  INC HL
  DEC B
  JP NZ,_RST75_2
  OR (HL)
  JP NZ,_RST75_3
  LD HL,ON_TIME_FLG
  CALL TRAPCHK

	DEFB $3E  ; "LD A,n" to Mask the next byte
	
; Routine at 7048
;
; Used by the routine at _RST75.
L1B88:
  XOR A
  LD (ON_TIME_TM+6),A

_RST75_3:

IF KC85
  JP _RST75_4
ENDIF

IF M100 | M10
  LD A,(ON_DATE)
ENDIF

  LD HL,ONDATEF
  CP (HL)
  LD (HL),A
  JP NC,_RST75_4
  
  LD HL,YEAR
  INC (HL)		; YEAR_2
  LD A,(HL)
  SUB $0A
  JP NZ,_RST75_4
  LD (HL),A
  INC HL		; CSRITP
  INC (HL)
  LD A,(HL)
  SUB $0A
  JP NZ,_RST75_4
  LD (HL),A

_RST75_4:
  CALL _CLICK_1
_RST75_5:
  JP _RST75_7

; This entry point is used by the routines at CHGET, LPT_BREAK, LCD_OUTPUT and
; TXT_CTL_U.
_RST75_6:
  LD A,(PWRINT)
  LD (TIMINT),A
  RET

; Routine at 7096
__KEY:
  CP $A5		; TK_LIST, "KEY LIST" command ?
  JP NZ,KEY_CONFIG
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL
  LD HL,FNKSTR
  LD C,$04
__KEY_0:
  CALL __KEY_1
  CALL __KEY_1
  CALL CR_LF
  DEC C
  JP NZ,__KEY_0
  POP HL
  RET
__KEY_1:
  LD B,$10
  CALL OUTS_B_CHARS
  LD B,$03
__KEY_2:
  RST OUTDO
  DEC B
  JP NZ,__KEY_2
  RET

; Send B number of characters from buffer pointed by HL to screen
;
; Used by the routines at __KEY and DSPFNK.
OUTS_B_CHARS:
  LD A,(HL)
  CP $7F		; BS
  JP Z,OUTS_B_CHARS_0
  CP ' '
  JP NC,OUTS_B_CHARS_1
OUTS_B_CHARS_0:
  LD A,' '
OUTS_B_CHARS_1:
  RST OUTDO
  INC HL
  DEC B
  JP NZ,OUTS_B_CHARS
  LD A,' '
  RET

; This entry point is used by the routine at __KEY.
KEY_CONFIG:
  CP '('
  JP Z,__MDM_3
  
  CP $97		; TK_ON, token for 'ON' keyword
  JP Z,KEY_STMTS
  CP $CB		; TK_OFF
  JP Z,KEY_STMTS
  CP $8F		; TK_STOP
  JP Z,KEY_STMTS
  
  CALL GETINT                 ; Get integer 0-255
  DEC A
  CP $08
  JP NC,FC_ERR
  EX DE,HL
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL			; *16
  LD BC,FNKSTR		; FUNCTION KEY AREA
  ADD HL,BC
  PUSH HL
  EX DE,HL
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD B,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP HL
  EX (SP),HL
  LD C,$0F
  LD A,B
  AND A
  JP Z,KEY_CONFIG_1
KEY_CONFIG_0:
  LD A,(DE)
  AND A
  JP Z,FC_ERR
  LD (HL),A
  INC DE
  INC HL
  DEC C
  JP Z,KEY_CONFIG_2
  DEC B
  JP NZ,KEY_CONFIG_0
KEY_CONFIG_1:
  LD (HL),B
  INC HL
  DEC C
  JP NZ,KEY_CONFIG_1
KEY_CONFIG_2:
  LD (HL),C
  CALL FNKSB
  CALL SAVE_BA_LBL
  POP HL
  RET

; Routine at 7255
__PSET:
  CALL COORD_PARMS
; This entry point is used by the routine at __PRESET.
__PSET_0:
  RRCA
  PUSH HL
  PUSH AF
  CALL C,PLOT
  POP AF
  CALL NC,UNPLOT
  POP HL
  RET

; Routine at 7270
__PRESET:
  CALL COORD_PARMS
  CPL
  JP __PSET_0

; LINE (graphics)
;
; Used by the routine at __LINE.
LINE_GFX:
  CP TK_MINUS       ; '-'
  EX DE,HL
  LD HL,(GR_X)
  EX DE,HL
  CALL NZ,COORD_PARMS
  PUSH DE
  RST SYNCHR
  DEFB TK_MINUS     ; '-'
  
  CALL COORD_PARMS
  PUSH DE
  LD DE,PLOT
  JP Z,LINE_GFX_1
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  POP DE
  RRCA
  JP C,LINE_GFX_0
  LD DE,UNPLOT
LINE_GFX_0:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
LINE_GFX_1:
  EX DE,HL
  LD (PIVOTCALL+1),HL
  EX DE,HL
  JP Z,L1CD2

  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  DEFB 'B'
  JP Z,LINE_GFX_4
  RST SYNCHR
  DEFB 'F'			; look for 'BF' (Box Filled)
  POP DE
  EX (SP),HL
  LD A,E
  SUB L
  JP NC,LINE_GFX_2
  CPL
  INC A
  LD L,E
LINE_GFX_2:
  LD B,A
  INC B
LINE_GFX_3:
  LD E,L
  CALL LINE_GFX_5
  INC L
  DEC B
  JP NZ,LINE_GFX_3
  POP HL
  RET
  
LINE_GFX_4:
  POP DE
  EX (SP),HL
  PUSH DE
  LD E,L
  CALL LINE_GFX_5
  POP DE
  PUSH DE
  LD D,H
  CALL LINE_GFX_5
  POP DE
  PUSH HL
  LD H,D
  CALL LINE_GFX_5
  POP HL
  LD L,E

  defb $01	; LD BC,NN
  
; Routine at 7378
;
; Used by the routine at LINE_GFX.
L1CD2:
  POP DE
  EX (SP),HL
  CALL LINE_GFX_5
  POP HL
  RET
  
LINE_GFX_5:
  PUSH HL
  PUSH DE
  PUSH BC
  LD A,L
  SUB E
  JP NC,LINE_GFX_6
  EX DE,HL
  CPL
  INC A
LINE_GFX_6:
  LD B,A
  LD C,$14		; C="INC D"
  LD A,H
  SUB D
  JP NC,LINE_GFX_7
  CPL
  INC A
  INC C
LINE_GFX_7:
  CP B
  JP C,LINE_GFX_8
  LD H,A
  LD L,B
  LD A,$1C		; INC	E
  JP LINE_GFX_9
  
LINE_GFX_8:
  LD L,A
  LD H,B
  LD A,C
  LD C,$1C		; INC	E
LINE_GFX_9:
  LD (PIVOTCALL+3),A

L1D02:
  LD A,C
  LD (PIVOTCALL+5),A
  LD B,H
  INC B
  LD A,H
  AND A
  RRA
  LD C,A
LINE_GFX_10:
  PUSH HL
  PUSH DE
  PUSH BC
  CALL PIVOTCALL
  POP BC
  POP DE
  POP HL
  CALL PIVOTCALL+5
  LD A,C
  ADD A,L
  LD C,A
  JP C,LINE_GFX_11
  CP H
  JP C,LINE_GFX_12
LINE_GFX_11:
  SUB H
  LD C,A
  CALL PIVOTCALL+3
LINE_GFX_12:
  DEC B
  JP NZ,LINE_GFX_10
  JP POPALL_0
  
; This entry point is used by the routines at __PSET and __PRESET.
COORD_PARMS:
  RST SYNCHR
  DEFB '('
  CALL GETINT                 ; Get integer 0-255
  CP $F0
  JP NC,FC_ERR
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  CP $40
  JP NC,FC_ERR
  POP AF
  LD D,A
  EX DE,HL
; This entry point is used by the routines at _INLIN and MOVE_TEXT.
COORD_PARMS_0:
  LD (GR_X),HL
  EX DE,HL
  LD A,(HL)
  CP ')'
  JP NZ,LINE_GFX_15
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$01
  RET

LINE_GFX_15:
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  LD A,E
  POP DE
  RET

; This entry point is used by the routine at __PRINT.
; Makes the '@' shortcut work (uses a single char count parameter to position the cursor)
PRINT_AT:
  CALL FPSINT
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  PUSH HL
  EX DE,HL
  LD A,(ACTV_Y)		; Number of active columns on screen (1-40)
  CPL
  INC A
  LD C,A
  LD B,$FF
  LD E,B
PRINT_AT_0:
  INC E
  LD D,L
  ADD HL,BC
  JP C,PRINT_AT_0
  LD A,(ACTV_Y)		; Number of active columns on screen (1-40)
  INC D
  CP D
  JP C,FC_ERR
  LD A,(ACTV_X)		; Number of active rows on screen (1-8)
  INC E
  CP E
  JP C,FC_ERR
  EX DE,HL	; cursor coordinates
  CALL POSIT
  LD A,H
  DEC A
  LD (TTYPOS),A		; Current horizontal position of cursor (0-39)
  POP HL
  RET

; Routine at 7568
;
; Used by the routine at NVRFIL.
CSRLIN:
  PUSH HL
  LD A,(CSRX)
  DEC A
; This entry point is used by the routine at MAXFILES.
CSRLIN_0:
  CALL INT_RESULT_A
  POP HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET

; Routine at 7579
;
; Used by the routine at ERL.
MAX_FN:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP TK_FILES		; token for "FILES" keyword
  JP Z,MAXFILES
  RST SYNCHR
  DEFB 'R'
  RST SYNCHR
  DEFB 'A'
  RST SYNCHR
  DEFB 'M'

; Routine at 7591
_MAXRAM:
  PUSH HL
  RST $38
  DEFB HC_MAXRAM
  
  LD HL,MAXRAM
  CALL DBL_ABS_0
  POP HL
  RET

; Routine at 7602
;
; Used by the routine at MAX_FN.
MAXFILES:
  PUSH HL
  LD A,(MAXFIL)
  JP CSRLIN_0

; Routine at 7609
;
; Used by the routine at ERL.
_HIMEM:
  PUSH HL
  LD HL,(HIMEM)
  CALL DBL_ABS_0
  POP HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET

; Routine at 7619
__WIDTH:
  RST $38
  DEFB HC_WIDT		; Offset: 58

; Routine at 7621
__SOUND:
  CP $97		; TK_ON, token for 'ON' keyword
  JP Z,SOUND_ON
  CP $CB		; TK_OFF
  JP Z,SOUND_OFF
  CALL GETWORD
  LD A,D
  AND $C0
  JP NZ,FC_ERR
  PUSH DE
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  AND A
  LD B,A
  POP DE
  JP NZ,MUSIC
  RET

; Routine at 7653
;
; Used by the routine at __SOUND.
SOUND_OFF:
  DEFB $3E  ; "LD A,n" to Mask the next byte

; Routine at 7654
;
; Used by the routine at __SOUND.
SOUND_ON:
  XOR A
  LD (SOUND_FLG),A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET

; Routine at 7660
__MOTOR:
  SUB $CB		; TK_OFF
  JP Z,MOTOR_OFF

; Routine at 7665
MOTOR_ON:
  RST SYNCHR
  DEFB $97		; TK_ON, token for 'ON' keyword
  DEC HL
  LD A,H

; Routine at 7669
;
; Used by the routine at __MOTOR.
MOTOR_OFF:
  LD E,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP DATAR_1

; Routine at 7674
__CALL:
  CALL GETWORD
  EX DE,HL
  LD (PIVOTCALL+1),HL
  EX DE,HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,__CALL_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CP ','
  JP Z,__CALL_0
  CALL GETINT                 ; Get integer 0-255
  JP Z,__CALL_1
__CALL_0:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETWORD
  POP AF
__CALL_1:
  PUSH HL
  EX DE,HL
  CALL PIVOTCALL
  POP HL
  RET

; Routine at 7714
__SCREEN:
  CP ','
  LD A,(SCREEN)		; Console type 0=LCD 1=CRT
  CALL NZ,GETINT
  CALL __SCREEN_0
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RET Z
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  PUSH HL
  AND A
  CALL FNBAR_IF_NZ
  POP HL
  RET
  
; This entry point is used by the routine at __MENU.
__SCREEN_0:
  PUSH HL
  LD (SCREEN),A		; Console type 0=LCD 1=CRT
  AND A
  LD DE,$2808		; D=40, E=8
  LD HL,(CSR_ROW)
  LD A,$0E

IF KC85 | M10
  RST $38
  DEFB HC_CHGCON
ENDIF

  JP Z,L1E52	;...mask out "XOR A"
  XOR A
  LD (SCREEN),A		; Console type 0=LCD 1=CRT
  RST $38
  DEFB HC_SCRE		; Offset: 62

; Routine at 7762
;
; Used by the routine at __SCREEN.
L1E52:
  LD (CSRX),HL
  EX DE,HL
  LD (ACTV_X),HL
  LD (CLMLST),A
  POP HL
  RET

; aka PRTLCD (hardcopy to printer)
;
; Used by the routine at CHGET.
__LCOPY:
  PUSH HL
  CALL INIT_OUTPUT_0
  LD HL,BEGLCD
  LD E,$08		; 8
__LCOPY_0:
  LD D,$28		; 40
__LCOPY_1:
  LD A,(HL)
  CALL LPT_OUT
  INC HL
  DEC D
  JP NZ,__LCOPY_1
  CALL INIT_OUTPUT_0
  DEC E
  JP NZ,__LCOPY_0
  POP HL
  RET

; This entry point is used by the routine at __MERGE.
MERGE_SUB:
  PUSH HL
  CALL RESFPT
  LD HL,(FILNAM+6)		; point to file name ext
  LD DE,$2020			; "  "
  RST CPDEHL
  PUSH AF
  JP Z,_MERGE_SUB_3
  LD DE,'B'+'A'*$100			; "BA" (as in filename string)
  RST CPDEHL
  JP NZ,_MERGE_SUB_5
_MERGE_SUB_3:
  CALL FINDBA
  JP Z,_MERGE_SUB_5
  POP AF
  POP BC
  POP AF
  JP Z,FC_ERR
  LD A,$00
  PUSH AF
  PUSH BC
  LD (DIRPNT),HL
  EX DE,HL
  LD (BASTXT),HL
  CALL LINKER
  POP HL
  LD A,(HL)
  CP ','
  JP NZ,_MERGE_SUB_4
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR
  DEFB 'R'
  POP AF
  LD A,$80			; BA file type
  SCF
  PUSH AF
_MERGE_SUB_4:
  POP AF
  LD (NLONLY),A
  JP C,RUN_FST
  CALL RUN_FST
  JP READY

_MERGE_SUB_5:
  POP AF
  POP HL
  LD D,RAM_DEVTYPE		; 'RAM' device
  JP NZ,__MERGE_0
  PUSH HL
  LD HL,$2020		; "  "
  LD (FILNAM+6),HL	; clear file name ext
  POP HL
  JP __MERGE_0

; This entry point is used by the routine at __SAVE.
__LCOPY_6:
  PUSH HL
  LD HL,(FILNAM+6)			; point to file name ext
  LD DE,'D'+'O'*$100		; "DO" (as in filename string)
  RST CPDEHL
  LD B,$00
  JP Z,__LCOPY_7
  LD DE,'B'+'A'*$100		; "BA" (as in filename string)
  RST CPDEHL
  LD B,$01
  JP Z,__LCOPY_7
  LD DE,$2020		; "  "
  RST CPDEHL
  LD B,$02
  JP NZ,NM_ERR		; NM error: bad file name

__LCOPY_7:
  POP HL
  PUSH BC
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,__LCOPY_9
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  DEFB 'A'
  POP BC
  DEC B
  JP Z,NM_ERR		; NM error: bad file name
__LCOPY_8:
  XOR A
  LD DE,$02+$100*RAM_DEVTYPE		; D = 'RAM' device, E = $02
  PUSH AF
  JP __SAVE_1

__LCOPY_9:
  POP BC
  DEC B
  JP M,__LCOPY_8
  CALL __NAME_2
  JP NZ,FC_ERR

; Routine at 7963
SAVEBA:
  CALL FINDBA
  CALL NZ,KILLASC_6
  CALL RESFPT
  CALL NXTDIR_0
  LD (DIRPNT),HL
  LD A,$80			; BA file type
  EX DE,HL
  LD HL,(BASTXT)
  EX DE,HL
  CALL ADD_DIR_ENTRY
  CALL RESFPT_9
  JP READY

; Routine at 7994
__FILES:
IF KC85 | M10
  RST $38
  DEFB HC_FILES
ENDIF
  PUSH HL
  CALL CATALOG
  POP HL
  JP CONSOLE_CRLF

; Display Catalog
;
; Used by the routine at __FILES.
CATALOG:
  LD HL,DIRECTORY-11
CATALOG_0:
  LD C,$03
  LD A,(ACTV_Y)
  CP 40
  JP Z,CATALOG_1
  LD C,$06		; 6 characters
CATALOG_1:
  CALL NXTDIR
  RET Z
  AND $18	; 24
  JP NZ,CATALOG_1
  
  PUSH HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH DE
  
  LD B,$06		; 6 characters
CATALOG_2:
  LD A,(HL)
  RST OUTDO
  INC HL
  DEC B
  JP NZ,CATALOG_2
  
  LD A,'.'
  RST OUTDO
  LD A,(HL)
  RST OUTDO
  INC HL
  LD A,(HL)
  RST OUTDO
  POP DE
  LD HL,(BASTXT)
  RST CPDEHL
  LD A,'*'
  LD B,' '
  JP Z,CATALOG_3
  LD A,B
CATALOG_3:
  RST OUTDO
  LD A,B
  RST OUTDO
  RST OUTDO
  POP HL
  DEC C
  JP NZ,CATALOG_1
  CALL CR_LF

IF KC85 | M10
  PUSH HL
  LD HL,$0000
  CALL ISCNTC
  POP HL
ENDIF

IF M100
  CALL ISCNTC
ENDIF

  JP CATALOG_0

; Routine at 8081
__KILL:
  CALL __NAME_1
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  LD A,D
  CP RAM_DEVTYPE	; 'RAM' device ?
  JP Z,__KILL_0
  RST $38
  DEFB HC_KILL		; Offset: 88
  
__KILL_0:
  PUSH HL

IF M100
  XOR A
  LD (NLONLY),A
  CALL CLSALL
ENDIF

  CALL RESFPT
  CALL FINDFL
  JP Z,FF_ERR
  LD B,A
  AND $20
  JP NZ,KILLBIN_0
  LD A,B
  AND $40
  JP Z,KILLASC_5

IF KC85 | M10
  LD A,B
  AND $02
  JP NZ,AO_ERR
ENDIF

; Kill a text (.DO) file, DE=TOP addr, HL=adrress of dir entry.
KILLASC:
  LD A,$E5

; Kill a text (.DO) file, DE=TOP addr, HL=adrress of dir entry.
;
; Used by the routines at __POWER and TEL_DOWNLD.
;KILLASC+1:
  ; PUSH	HL
  LD BC,$0000
  LD (HL),C
  LD L,E
  LD H,D
KILLASC_0:
  LD A,(DE)
  INC DE
  INC BC
  CP $1A		; EOF
  JP NZ,KILLASC_0
  CALL MASDEL		; Delete specified no of characters, BC=number, HL=address
KILLASC_1:
  CALL __EOF_4
  CALL RESFPT
  POP HL
  RET

; This entry point is used by the routine at CSAVEM.
KILLBIN:
  PUSH HL
; This entry point is used by the routine at __KILL.
KILLBIN_0:
  LD (HL),$00
  LD HL,(CO_FILES)
  PUSH HL
  EX DE,HL
  PUSH HL
  INC HL
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  LD HL,$0006
  ADD HL,BC			; char count
  LD B,H
  LD C,L
  POP HL
  CALL MASDEL		; Delete specified no of characters, BC=number, HL=address
  POP HL
  LD (CO_FILES),HL
  JP KILLASC_1

; This entry point is used by the routine at __EDIT.
KILLASC_4:
  CALL RESFPT
  LD HL,(EDTDIR)
  EX DE,HL
  LD HL,SUZUKI+21
  JP KILLASC+1

; This entry point is used by the routine at __KILL.
KILLASC_5:
  PUSH HL
  LD HL,(BASTXT)
  RST CPDEHL
  POP HL
  JP Z,FC_ERR
  CALL KILLASC_6
  CALL _CLVAR
  JP READY

; This entry point is used by the routine at SAVEBA.
KILLASC_6:
  LD (HL),$00
  LD HL,(BASTXT)
  RST CPDEHL
  PUSH AF
  PUSH DE
  CALL CHEAD
  POP DE
  INC HL
  CALL __NEW_3
  PUSH BC
  CALL RESFPT
  POP BC
  POP AF
  RET Z
  RET C
  LD HL,(BASTXT)
  ADD HL,BC
  LD (BASTXT),HL
  RET

; Routine at 8247
__NAME:
  CALL __NAME_1
  PUSH DE
  CALL SWAPNM
  RST SYNCHR
  DEFB 'A'
  RST SYNCHR
  DEFB 'S'
  CALL __NAME_1
  LD A,D
  POP DE
  CP D
  JP NZ,FC_ERR
  CP RAM_DEVTYPE	; D = 'RAM' device ?
  JP Z,__NAME_0

  RST $38
  DEFB HC_NAME		; Offset: 90
  
__NAME_0:
  PUSH HL
  CALL FINDFL
  JP NZ,FC_ERR
  CALL SWAPNM
  CALL FINDFL
  JP Z,FF_ERR
  PUSH HL
  LD HL,(FILNAM+6)
  EX DE,HL
  LD HL,(FILNM2+6)
  RST CPDEHL			; compare file name extensions
  JP NZ,FC_ERR
  POP HL
  CALL SWAPNM
  INC HL
  INC HL
  INC HL
  CALL COPY_NAME
  POP HL
  RET

; This entry point is used by the routines at __KILL, SAVEM and LOADM_RUNM.
__NAME_1:
  CALL FILE_PARMS
  RET NZ
  LD D,RAM_DEVTYPE		; 'RAM' device
  RET

; This entry point is used by the routines at __LCOPY and __NEW.
__NAME_2:
  LD HL,(DIRPNT)
  LD DE,SUZUKI-1
  RST CPDEHL
  RET

; Routine at 8329
;
; Used by the routines at CSAVEM and CLOADM.
FINDCO:
  LD BC,'C'*$100+'O'
  JP FIND_FILEXT

; This entry point is used by the routines at RAM_OPN, MAKTXT and TEL_UPLD.
FINDCO_0:
  LD HL,(FILNAM+6)	; point to file name ext
  LD DE,$2020		; "  "
  RST CPDEHL
  JP Z,FINDDO
  LD DE,'D'+'O'*$100	; "DO" (as in filename string)
  RST CPDEHL
  JP NZ,NM_ERR			; NM error: bad file name

; Routine at 8352
;
; Used by the routine at FINDCO.
FINDDO:
  LD BC,'D'*$100+'O'
  JP FIND_FILEXT

; This entry point is used by the routines at __LCOPY and SAVEBA.
FINDBA:
  LD BC,'B'*$100+'A'

; This entry point is used by the routine at FINDCO.
FIND_FILEXT:
  LD HL,FILNAM+6	; point to file name ext
  LD (HL),B
  INC HL
  LD (HL),C

; Finf dall types of files, with extensions
;
; Used by the routines at __KILL and __NAME.
FINDFL:
  LD HL,DIRECTORY-11

  ;LD A,$E1
  DEFB $3E  ; "LD A,n" to Mask the next byte

; Routine at 8371
L20B3:
  POP HL
  CALL NXTDIR
  RET Z
  PUSH HL
  INC HL
  INC HL
  LD DE,FILNAM-1
  LD B,$08
FINDFL_0:
  INC DE
  INC HL
  LD A,(DE)
  CP (HL)
  JP NZ,L20B3
  DEC B
  JP NZ,FINDFL_0
  POP HL
  LD A,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  AND A
  RET

; Routine at 8405
;
; Used by the routines at CATALOG, FINDFL and RESFPT.
NXTDIR:
  PUSH BC
  LD BC,11		; directory entry size
  ADD HL,BC
  POP BC
  LD A,(HL)
  CP $FF
  RET Z
  AND A
  JP P,NXTDIR
  RET

; This entry point is used by the routines at SAVEBA, MAKTXT and CSAVEM.
NXTDIR_0:
  LD A,(EDITMODE)
  AND A
  LD HL,SUZUKI+21
  RET NZ
  LD HL,SUZUKI+21
  LD BC,11
NXTDIR_1:
  ADD HL,BC
  LD A,(HL)
  CP $FF
  JP Z,FL_ERR
  ADD A,A
  JP C,NXTDIR_1
  RET

; Routine at 8446
__NEW:
  RET NZ
; This entry point is used by the routines at __CLOAD, LOAD_RECORD, __MERGE and
; BOOT.

CLRPTR:
  CALL __NAME_2
  CALL NZ,RESFPT
  
IF KC85 | M10
  CALL CLSALL
ENDIF
  
  LD HL,SUZUKI-1
  LD (DIRPNT),HL
  LD HL,(SUZUKI)
  LD (BASTXT),HL
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  EX DE,HL
  LD HL,(DO_FILES)
  CALL __NEW_3

IF KC85 | M10
  LD HL,$0000
  LD (RAM_FILES),HL
  CALL RESFPT
ENDIF

IF M100
  LD HL,(RAM_FILES)
  ADD HL,BC
  LD (RAM_FILES),HL
  LD HL,$FFFF
  LD (PASPNT),HL
ENDIF

  JP RUN_FST


; This entry point is used by the routine at __EDIT.
__NEW_2:
  LD HL,(LBLIST)
  EX DE,HL
  LD HL,(LBEDIT)
  
; This entry point is used by the routine at KILLASC.
__NEW_3:
  LD A,L
  SUB E
  LD C,A
  LD A,H
  SBC A,D
  LD B,A
  EX DE,HL
  CALL MASDEL		; Delete specified no of characters, BC=number, HL=address
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  RET

; Routine at 8518
;
; Used by the routines at CHGET, RAM_OPN, RAM_INPUT, __LCOPY, SAVEBA, __KILL,
; KILLASC, __NEW, MAKTXT, SWAPNM, CSAVEM, CLOADM, TEL_UPLD, TEL_DOWNLD, __MENU,
; __EDIT and TXT_CTL_U.
RESFPT:

IF KC85 | M10
  CALL RESFPT_3
ENDIF

  XOR A
  LD (FILETYPE),A
  LD HL,(RAM)		; Lowest RAM memory address used by system ($8000 if 32K RAM)
  INC HL
RESFPT_0:
  PUSH HL
  LD HL,SCHDIR	; 
  LD DE,$FFFF
RESFPT_1:
  CALL NXTDIR
  JP Z,RESFPT_2

IF KC85 | M10
  CP $F0
  JP Z,RESFPT_1
ENDIF

  RRCA
  JP C,RESFPT_1
  PUSH HL
  INC HL
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RST CPDEHL
  POP HL
  JP NC,RESFPT_1
  LD B,H
  LD C,L
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  JP RESFPT_1

RESFPT_2:
  LD A,E
  AND D
  INC A
  POP DE
  JP Z,RESFPT_3
  LD H,B
  LD L,C
  LD A,(HL)
  OR $01
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL
  CALL RESFPT_5
  JP RESFPT_0

RESFPT_3:
  LD HL,DIRECTORY-11
RESFPT_4:
  CALL NXTDIR
  RET Z
  AND $FE
  LD (HL),A
  JP RESFPT_4

RESFPT_5:
  LD A,(FILETYPE)
  DEC A
  JP M,RESFPT_8
  JP Z,RESFPT_6
  INC HL
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  INC HL
  INC HL
  ADD HL,DE
  RET

RESFPT_6:
  LD A,$1A		; EOF
RESFPT_7:
  CP (HL)
  INC HL
  JP NZ,RESFPT_7
  EX DE,HL
  LD HL,(CO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NZ
  LD A,$02
  LD (FILETYPE),A
  RET

RESFPT_8:
  EX DE,HL
  CALL CHEAD
  INC HL
  EX DE,HL
  LD HL,(DO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NZ
  LD A,$01
  LD (FILETYPE),A
  RET

; This entry point is used by the routine at SAVEBA.
RESFPT_9:
  LD HL,(VARTAB)
  LD (VAREND),HL
  LD (STREND),HL
  LD HL,(DO_FILES)
  DEC HL
  LD (SUZUKI),HL
  INC HL
  LD BC,$0002
  EX DE,HL
  CALL MAKHOL_0
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  JP RESFPT

; Count the number of characters in (HL), null terminated
;
; Used by the routines at OPENDO, TEL_UPLD and TXT_CTL_G.
COUNT_CHARS:
  PUSH HL
  LD E,$FF
COUNT_CHARS_0:
  INC E
  LD A,(HL)
  INC HL
  AND A
  JP NZ,COUNT_CHARS_0
  POP HL
  RET

; Routine at 8710
;
; Used by the routines at DWNLDR and TEXT.
OPENDO:
  CALL COUNT_CHARS
  CALL FNAME
  JP NZ,SN_ERR

; Create a text file, max 8 bytes in FILNAM (no 'DO' ext). On exit: HL=TOP
; address of file, DE=file dictionary, CY if file exist.
;
; Used by the routine at RAM_OPN.
MAKTXT:
  CALL RESFPT
  CALL FINDCO_0
  EX DE,HL
  SCF
  RET NZ
  CALL NXTDIR_0
  PUSH HL
  LD HL,(DO_FILES)
  PUSH HL
  LD A,$1A		; EOF
  CALL INSCHR
  JP C,OM_ERR
  POP DE
  POP HL
  PUSH HL
  PUSH DE
  LD A,$C0		; DO file type
  DEC DE
  CALL ADD_DIR_ENTRY
  CALL RESFPT
  POP HL
  POP DE
  AND A
  RET

; This entry point is used by the routines at SAVEBA and CSAVEM.
ADD_DIR_ENTRY:
  PUSH DE
  LD (HL),A
  INC HL
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL

  DEFB $3E  ; "LD A,n" to Mask the next byte

; Routine at 8769
;
; Used by the routine at __NAME.
COPY_NAME:
  PUSH DE
  LD DE,FILNAM
  LD B,$08		; 8 characters
  CALL REV_LDIR_B
  POP DE
  RET

; Routine at 8780
;
; Used by the routine at __NAME.
SWAPNM:
  PUSH HL
  LD B,$09
  LD DE,FILNAM
  LD HL,FILNM2
SWAPNM_0:
  LD C,(HL)
  LD A,(DE)
  LD (HL),A
  LD A,C
  LD (DE),A
  INC DE
  INC HL
  DEC B
  JP NZ,SWAPNM_0
  POP HL
  RET

; This entry point is used by the routines at __CLEAR and TXT_CTL_U.
SWAPNM_1:
  CALL RESFPT
  LD HL,$FFFF
  LD (PASPNT),HL
  LD B,H
  LD C,L
  LD HL,(HAYASHI)		; Paste buffer file
  PUSH HL
  LD A,$1A		; EOF
SWAPNM_2:
  CP (HL)
  INC BC
  INC HL
  JP NZ,SWAPNM_2
  POP HL
  CALL MASDEL		; Delete specified no of characters, BC=number, HL=address
  JP RESFPT

; Routine at 8832
__CSAVE:
  CP $4D
  JP Z,CSAVEM
  CALL GETPARM_SAVE
; This entry point is used by the routine at __SAVE.
__CSAVE_0:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,__CSAVE_1
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  DEFB 'A'
  LD E,$02
  AND A
  PUSH AF
  JP __SAVE_1

__CSAVE_1:
  CALL LINKER
  EX DE,HL
  LD HL,(BASTXT)
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  DEC HL
  LD A,H
  OR L
  JP Z,RESTART
  LD (PRLEN),HL
  PUSH HL
  CALL CAS_OPNO_BA
  CALL CAS_OPNO_CO_3
  POP DE
  LD HL,(BASTXT)

; Save the buffer pointed to by HL to tape, on exit jp to 'READY'
;
; Used by the routine at CSAVEM.
SAVE_BUFFER:
  LD C,$00
SAVE_BUFFER_0:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,SAVE_BUFFER_0
  CALL CAS_OPNO_CO_1
  JP RESTART

; SAVEM Statement
;
; Used by the routine at __SAVE.
SAVEM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL __NAME_1
  LD A,D
  CP CAS_DEVTYPE	; D = 'CAS' device ?
  JP Z,CSAVEM_0
  CP RAM_DEVTYPE	; D = 'RAM' device ?
  JP Z,CSAVEM_1
  RST $38
  DEFB HC_MSAVE		; Offset: 92

; CSAVEM Statement
;
; Used by the routine at __CSAVE.
CSAVEM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL GETPARM_SAVE
; This entry point is used by the routine at SAVEM.
CSAVEM_0:
  CALL CSAVEM_2
  CALL CAS_OPNO_CO
  CALL CAS_OPNO_CO_3
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(TOP)
  JP SAVE_BUFFER

; This entry point is used by the routine at SAVEM.
CSAVEM_1:
  CALL CSAVEM_2
  CALL RESFPT
  CALL FINDCO
  CALL NZ,KILLBIN
  CALL NXTDIR_0
  PUSH HL
  LD HL,(CO_FILES)
  PUSH HL
  LD HL,(PRLEN)
  LD A,H
  OR L
  JP Z,OM_ERR
  PUSH HL
  LD BC,$0006
  ADD HL,BC				; char count
  LD B,H
  LD C,L
  LD HL,(VARTAB)
  LD (TEMP),HL
  CALL NC,MAKHOL
  JP C,OM_ERR
  EX DE,HL
  LD HL,TOP
  CALL CLOADM_8
  LD HL,(TOP)
  POP BC
  CALL _LDIR
  POP HL
  LD (CO_FILES),HL
  POP HL
  LD A,$A0			; CO file type
  EX DE,HL
  LD HL,(TEMP)
  EX DE,HL
  CALL ADD_DIR_ENTRY
  CALL RESFPT
IF KC85 | M10
  JP RESTART
ENDIF
IF M100
  JP READY
ENDIF


CSAVEM_2:
  CALL CSAVEM_3
  PUSH DE
  CALL CSAVEM_3
  PUSH DE
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD DE,$0000
  CALL NZ,CSAVEM_3
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  EX DE,HL
  LD (EXE),HL
  POP DE
  POP HL
  LD (TOP),HL
  LD A,E
  SUB L
  LD L,A
  LD A,D
  SBC A,H
  LD H,A
  JP C,FC_ERR
  INC HL
  LD (PRLEN),HL
  RET

CSAVEM_3:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  JP GETWORD

; Routine at 9079
__CLOAD:
  CP 'M'
  JP Z,CLOADM
  CP TK_PRINT		 ; TK_PRINT  (=CLOAD?)
  JP Z,CVERIFY
  CALL GETPARM_LOAD
  OR $FF
  PUSH AF

; This entry point is used by the routine at __MERGE.
__CLOAD_0:
  POP AF
  PUSH AF
  JP NZ,__CLOAD_1
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,FC_ERR
__CLOAD_1:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  LD A,$00
  SCF
  CCF
  JP Z,CLOAD_NO_AUTORUN
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  DEFB 'R'
  JP NZ,SN_ERR
  POP AF
  SCF
  PUSH AF
  LD A,$80			; BA file type
CLOAD_NO_AUTORUN:
  PUSH AF
  LD (NLONLY),A
__CLOAD_3:
  CALL CAS_OPNI_CO_1
  CP $D3			; BA type?
  JP Z,BA_FILE_FOUND
  CP $9C			; DO type?
  JP Z,DO_FILE_FOUND
CLOAD_SKIP:
  CALL CAS_OPNI_SKIP
  JP __CLOAD_3

BA_FILE_FOUND:
  POP BC
  POP AF
  PUSH AF
  PUSH BC
  JP Z,CLOAD_SKIP
  POP AF
  POP AF
  SBC A,A
  LD (FILFLG),A
  CALL CAS_OPNI_FOUND
  CALL CLRPTR
  LD HL,(PRLEN)
  PUSH HL
  LD B,H
  LD C,L
  LD HL,(BASTXT)
  PUSH HL
  CALL MAKHOL
  JP C,OM_ERR
  LD HL,LOAD_RECORD_1
  LD (ERRTRP),HL
  LD HL,(DO_FILES)
  ADD HL,BC
  LD (DO_FILES),HL
  CALL CAS_LOAD_BIN
  POP HL
  POP DE
  CALL LOAD_RECORD
  JP NZ,LOAD_RECORD_1
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL CTOFF
  CALL CONSOLE_CRLF
  CALL LINKER
  CALL RUN_FST
  LD A,(FILFLG)
  AND A
  JP NZ,NEWSTT
  JP READY

; Load a record from the cassette and put it in (HL)
;
; Used by the routines at __CLOAD and CLOADM.
LOAD_RECORD:
  LD C,$00
LOAD_RECORD_0:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,LOAD_RECORD_0
  CALL CASIN
  LD A,C
  AND A
  RET

; This entry point is used by the routine at __CLOAD.
LOAD_RECORD_1:
  CALL CLRPTR
  LD HL,$0000
  LD (ERRTRP),HL
  JP CAS_ERR_EXIT

; This entry point is used by the routine at __CLOAD.
DO_FILE_FOUND:
  CALL CAS_OPNI_FOUND
  CALL CONSOLE_CRLF
  LD HL,(FILTAB)
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD (PTRFIL),HL			; Redirect I/O
  LD (HL),$01
  INC HL
  INC HL
  INC HL
  INC HL
  LD (HL),CAS_DEVTYPE
  INC HL
  INC HL
  XOR A
  LD (HL),A
  INC HL
  LD (HL),A
  LD (CASPRV),A
  JP __MERGE_3

; This entry point is used by the routine at __CLOAD.
CVERIFY:
  CALL GETPARM_VRFY
  PUSH HL
  CALL CAS_OPNI_BA
  CALL CAS_LOAD_BIN
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(BASTXT)
  CALL LDIR_B_3
  JP NZ,VERIFY_ERROR
  LD A,(HL)
  INC HL
  OR (HL)
  JP NZ,VERIFY_ERROR
LOAD_RECORD_4:
  CALL CTOFF
  POP HL
  RET
  
; This entry point is used by the routine at LDIR_B.
VERIFY_ERROR:
  LD HL,VRFY_ERRM
  CALL PRINT_LINE
  JP LOAD_RECORD_4
  
; Message at 9345
VRFY_ERRM:
  DEFM "Verify failed"
  DEFB $0D
  DEFB $0A
  DEFB $00

; LOADM and RUNM Statement
;
; Used by the routine at __MERGE.
LOADM_RUNM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH AF
  JP Z,FC_ERR
  CALL __NAME_1
  LD A,D
  CP CAS_DEVTYPE	; D = 'CAS' device ?
  JP Z,CLOADM_CAS
  CP RAM_DEVTYPE	; D = 'RAM' device ?
  JP Z,CLOADM_RAM
  RST $38
  DEFB HC_MLOAD		; Offset: 94

; Routine at 9383
;
; Used by the routine at __CLOAD.
CLOADM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP TK_PRINT		 ; TK_PRINT  (=CLOADM?)
  JP Z,CVERIFYM
  CALL GETPARM_LOAD
  OR $FF
  PUSH AF
  
; This entry point is used by the routine at LOADM_RUNM.
CLOADM_CAS:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  PUSH HL
  CALL CAS_OPNI_CO
  LD HL,(EXE)
  LD A,H
  OR L
  JP NZ,CLOADM_1
  POP HL
  POP AF
  PUSH AF
  PUSH HL
  JP C,FC_ERR
CLOADM_1:
  CALL CLOAD_PARMS
  JP C,OM_ERR
  CALL CAS_LOAD_BIN
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(TOP)
  CALL LOAD_RECORD
  JP NZ,CAS_ERR_EXIT
  CALL CTOFF
  JP CLOADM_4

; This entry point is used by the routine at LOADM_RUNM.
CLOADM_RAM:
  PUSH HL
  CALL RESFPT
  CALL FINDCO
  JP Z,FF_ERR
  EX DE,HL
  CALL CLOADM_7
  PUSH HL
  LD HL,(EXE)
  LD A,H
  OR L
  JP NZ,CLOADM_3
  POP DE
  POP HL
  POP AF
  PUSH AF
  PUSH HL
  PUSH DE
  JP C,FC_ERR
CLOADM_3:
  CALL CLOAD_PARMS
  JP C,OM_ERR
  LD HL,(PRLEN)
  LD B,H
  LD C,L
  LD HL,(TOP)
  EX DE,HL
  POP HL
  CALL _LDIR
CLOADM_4:
  POP HL
  POP AF
  JP NC,_CLVAR
  CALL _CLVAR
  LD HL,(EXE)
  LD (PIVOTCALL+1),HL
  CALL PIVOTCALL
  LD HL,(TEMP)
  JP NEWSTT

CLOAD_PARMS:
  CALL CLOAD_PRPARM
; This entry point is used by the routine at LDIR_B.
_CLOAD_PARMS:
  LD HL,(HIMEM)
  EX DE,HL
  LD HL,(TOP)
  RST CPDEHL
  RET

; This entry point is used by the routine at LDIR_B.
CLOADM_7:
  LD DE,TOP
; This entry point is used by the routine at CSAVEM.
CLOADM_8:
  LD B,$06		; 6 characters

; Move memory pointed to by HL to the memory pointed to by DE for B number of
; bytes.
;
; Used by the routines at RAM_INPUT, GET_DAY, CHGDSP, TXT_CTL_L, LOAD_BA_LBL,
; SET_CLOCK_HL and BOOT.
LDIR_B:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC B
  JP NZ,LDIR_B
  RET

; This entry point is used by the routine at __MENU.
; Load CO program and execute it
MENU_LDEXEC:
  CALL CLOADM_7
  PUSH HL
  CALL _CLOAD_PARMS
  JP C,CLOAD_STOP
  EX DE,HL
  LD HL,(PRLEN)
  LD B,H
  LD C,L
  POP HL
  CALL _LDIR
  LD HL,(EXE)
  LD A,H
  OR L
  LD (PIVOTCALL+1),HL
  CALL NZ,PIVOTCALL
  JP __MENU

CLOAD_STOP:
  CALL __BEEP
  JP __MENU

; This entry point is used by the routine at CLOADM.
CVERIFYM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL GETPARM_LOAD
  PUSH HL
  CALL CAS_OPNI_CO
  CALL CAS_LOAD_BIN
  LD HL,(PRLEN)
  EX DE,HL
  LD HL,(TOP)
  CALL LDIR_B_3
  JP NZ,VERIFY_ERROR
  CALL CTOFF
  POP HL
  RET

; This entry point is used by the routine at LOAD_RECORD.
LDIR_B_3:
  LD C,$00
LDIR_B_4:
  CALL CASIN
  CP (HL)
  RET NZ
  INC HL
  DEC DE
  LD A,D
  OR E
  JP NZ,LDIR_B_4
  CALL CASIN
  LD A,C
  AND A
  RET

; This entry point is used by the routine at CLOADM.
CLOAD_PRPARM:
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  RET NZ

; Routine at 9643
PRPARM:
  LD HL,(TOP)
  PUSH HL
  EX DE,HL
  LD HL,TOP_MSG
  CALL PRPARM_0
  LD HL,(PRLEN)
  DEC HL
  POP DE
  ADD HL,DE
  EX DE,HL
  LD HL,END_MSG
  CALL PRPARM_0
  LD HL,(EXE)
  LD A,H
  OR L
  RET Z
  EX DE,HL
  LD HL,EXE_MSG
PRPARM_0:
  PUSH DE
  CALL PRINT_LINE
  POP HL
  JP NUMPRT

; Message at 9685  ($25D5)
TOP_MSG:
  DEFM "Top: "
  DEFB $00
END_MSG:
  DEFM "End: "
  DEFB $00
EXE_MSG:
  DEFM "Exe: "
  DEFB $00

; Routine at 9703
; This entry point is used by the routines at __CLOAD, CLOADM and LDIR_B.
GETPARM_LOAD:
  DEC HL
; This entry point is used by the routine at LOAD_RECORD.
GETPARM_VRFY:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,GETPARM_SAVE
  LD B,$06		; 6 characters
  LD DE,FILNAM
  LD A,' '
GETPARM_LOOP:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,GETPARM_LOOP
  JP GETPARM_DEV

; This entry point is used by the routines at __CSAVE and CSAVEM.
GETPARM_SAVE:
  CALL FILE_PARMS
  JP NZ,GETPARM_6

GETPARM_DEV:
  LD D,CAS_DEVTYPE	; D = 'CAS' device
GETPARM_6:
  LD A,D
  CP CAS_DEVTYPE	; D = 'CAS' device ?
  JP NZ,FC_ERR
  RET

; CAS open for output for BASIC files
;
; Used by the routine at __CSAVE.
CAS_OPNO_BA:
  LD A,$D3		; BA type

  defb $01	; LD BC,NN

; CAS open for output for TEXT files
;
; Used by the routine at CAS_OPN.
CAS_OPNO_DO:
  LD A,$9C		; DO type

  defb $01	; LD BC,NN

; CAS open for output for Command files
;
; Used by the routine at CSAVEM.
CAS_OPNO_CO:
  LD A,$D0		; CO type
  PUSH AF
  CALL IONTERC
  POP AF
  CALL CSOUT
  LD C,$00
  LD HL,FILNAM
  LD DE,$0602		; D=6, E=2
CAS_OPNO_CO_0:
  LD A,(HL)
  CALL CSOUT
  INC HL
  DEC D
  JP NZ,CAS_OPNO_CO_0
  LD HL,TOP
  LD D,$0A			; 10
  DEC E
  JP NZ,CAS_OPNO_CO_0
; This entry point is used by the routines at CAS_INPUT and SAVE_BUFFER.
CAS_OPNO_CO_1:
  LD A,C
  CPL
  INC A
  CALL CSOUT
  LD B,$14			; 20
CAS_OPNO_CO_2:
  XOR A
  CALL CSOUT
  DEC B
  JP NZ,CAS_OPNO_CO_2
  JP CTOFF

; This entry point is used by the routines at CAS_INPUT, __CSAVE and CSAVEM.
CAS_OPNO_CO_3:
  CALL IONTERC
  LD A,$8D
  JP CSOUT

; CAS open for input for BASIC files
;
; Used by the routine at LOAD_RECORD.
CAS_OPNI_BA:
  LD B,$D3	; BA type
  
  DEFB $11	; LD DE,NN

; CAS open for input for text files
;
; Used by the routine at CAS_OPN.
CAS_OPNI_DO:
  LD B,$9C	; DO type
  
  DEFB $11	; LD DE,NN

; CAS open for input for Command files
;
; Used by the routines at CLOADM and LDIR_B.
CAS_OPNI_CO:
  LD B,$D0		; CO type
  
CAS_OPNI_CO_0:
  PUSH BC
  CALL CAS_OPNI_CO_1
  POP BC
  CP B
  JP Z,CAS_OPNI_FOUND

IF KC85 | M10
  PUSH BC
ENDIF

  CALL CAS_OPNI_SKIP
IF KC85 | M10
  JP CAS_OPNI_CO_0+1
ENDIF
IF M100
  JP CAS_OPNI_CO_0
ENDIF
  
; This entry point is used by the routine at __CLOAD.
CAS_OPNI_CO_1:
  CALL HEADER
  CALL CASIN
  CP $D3		; BA type?
  JP Z,CAS_OPNI_CO_2
  CP $9C		; DO type?
  JP Z,CAS_OPNI_CO_2
  CP $D0		; CO type ?
  JP NZ,CAS_OPNI_CO_1

CAS_OPNI_CO_2:
  PUSH AF
  LD HL,FILNM2
  LD DE,$0602		; D=6, E=2
  LD C,$00
CAS_OPNI_CO_3:
  CALL CASIN
  LD (HL),A
  INC HL
  DEC D
  JP NZ,CAS_OPNI_CO_3
  LD HL,TOP
  LD D,$0A			;10
  DEC E
  JP NZ,CAS_OPNI_CO_3
  CALL CASIN
  LD A,C
  AND A
  JP NZ,CAS_OPNI_CO_9
  CALL CTOFF
  LD HL,FILNAM
  LD B,$06		; 6 characters
  LD A,' '
CAS_OPNI_CO_4:
  CP (HL)
  JP NZ,CAS_OPNI_CO_5
  INC HL
  DEC B
  JP NZ,CAS_OPNI_CO_4
  JP CAS_OPNI_CO_7
CAS_OPNI_CO_5:
  LD DE,FILNAM
  LD HL,FILNM2
  LD B,$06		; 6 characters
CAS_OPNI_CO_6:
  LD A,(DE)
  CP (HL)
  JP NZ,CAS_OPNI_CO_8
  INC DE
  INC HL
  DEC B
  JP NZ,CAS_OPNI_CO_6
CAS_OPNI_CO_7:
  POP AF
  RET

CAS_OPNI_CO_8:
  CALL CAS_OPNI_SKIP
CAS_OPNI_CO_9:
  POP AF
  JP CAS_OPNI_CO_1

; This entry point is used by the routines at CAS_INPUT, __CLOAD, LOAD_RECORD,
; CLOADM and LDIR_B.
CAS_LOAD_BIN:
  CALL HEADER
  CALL CASIN
  CP $8D		; binary byte stream ?
  JP NZ,CAS_ERR_EXIT
  RET

; This entry point is used by the routine at __CLOAD.
CAS_OPNI_SKIP:
  LD DE,SKIP_MSG
  JP CAS_OPNI_FOUND_0
; This entry point is used by the routines at __CLOAD and LOAD_RECORD.
CAS_OPNI_FOUND:
  LD DE,FOUND_MSG
CAS_OPNI_FOUND_0:
  LD HL,(CURLIN)
  INC HL
  LD A,H
  OR L
  RET NZ
  EX DE,HL
  CALL PRINT_LINE
  XOR A
  LD (FILNM2+6),A		; clear file ext
  LD HL,FILNM2
  CALL PRS
  JP ERAEOL
  
; Message at 9982 ($26fe)
FOUND_MSG:
  DEFM "Found:"
  DEFB $00
  
SKIP_MSG:
  DEFM "Skip :"
  DEFB $00


;
; THE FOLLOWING ROUTINE COMPARES TWO STRINGS
; ONE WITH DESC IN [D,E] OTHER WITH DESC. IN [FACLO, FACLO+1]
; A=0 IF STRINGS EQUAL
; A=377 IF B,C,D,E .GT. FACLO
; A=1 IF B,C,D,E .LT. FACLO
;
; Routine at 9996
STRCMP:
  CALL GETSTR       ;FREE UP THE FAC STRING, AND GET THE POINTER TO THE FAC DESCRIPTOR IN [H,L]
  LD A,(HL)         ;SAVE THE LENGTH OF THE FAC STRING IN [A]
  INC HL
  LD C,(HL)         ;SAVE THE POINTER AT THE FAC STRING DATA IN [B,C]
  INC HL
  LD B,(HL)
  POP DE            ;GET THE STACK STRING POINTER
  PUSH BC           ;SAVE THE POINTER AT THE FAC STRING DATA
  PUSH AF           ;SAVE THE FAC STRING LENGTH
  CALL GSTRDE       ;FREE UP THE STACK STRING AND RETURN
                    ;THE POINTER TO THE STACK STRING DESCRIPTOR IN [H,L]
  POP AF
  LD D,A
  LD E,(HL)         ;[E]=LENGTH OF STACK STRING
  INC HL
  LD C,(HL)         ;[B,C]=POINTER AT STACK STRING
  INC HL
  LD B,(HL)
  POP HL            ;GET BACK 2ND CHARACTER POINTER
CSLOOP:
  LD A,E            ;BOTH STRINGS ENDED
  OR D              ;TEST BY OR'ING THE LENGTHS TOGETHER
  RET Z             ;IF SO, RETURN WITH A ZERO
  LD A,D            ;GET FACLO STRING LENGTH
  SUB $01           ;SET CARRY AND MAKE [A]=255 IF [D]=0
  RET C             ;RETURN IF THAT STRING ENDED
  XOR A             ;MUST NOT HAVE BEEN ZERO, TEST CASE
  CP E              ;OF B,C,D,E STRING HAVING ENDED FIRST
  INC A             ;RETURN WITH A=1
  RET NC            ;TEST THE CONDITION

;HERE WHEN NEITHER STRING ENDED
  DEC D             ;DECREMENT BOTH CHARACTER COUNTS
  DEC E             
  LD A,(BC)         ;GET CHARACTER FROM B,C,D,E STRING
  INC BC            
  CP (HL)           ;COMPARE WITH FACLO STRING
  INC HL            ;BUMP POINTERS (INX DOESNT CLOBBER CC'S)
  JP Z,CSLOOP       ;IF BOTH THE SAME, MUST BE MORE TO STRINGS
  CCF               ;HERE WHEN STRINGS DIFFER
  JP SIGNS          ;SET [A] ACCORDING TO CARRY

; STR BASIC function entry
__STR_S:                                             ;IS A NUMERIC
  CALL FOUT                                          ;DO ITS OUTPUT
  CALL CRTST        ; Create string entry            ;SCAN IT AND TURN IT INTO A STRING
  CALL GSTRCU       ; Current string to pool         ;FREE UP THE TEMP

; Save string in string area
SAVSTR:
  LD BC,TOPOOL      ; Save in string pool
  PUSH BC           ; Save address on stack          ;SET UP ANSWER IN NEW TEMP

;
; STRCPY CREATES A COPY OF THE STRING WHOSE DESCRIPTOR IS POINTED TO BY [H,L].
; ON RETURN [D,E] POINTS TO DSCTMP WHICH HAS THE STRING INFO (LENGTH, WHERE COPIED TO)
;
; This entry point is used by the routines at __LET and INSTR.
STRCPY:
  LD A,(HL)			; Get string length                   ;GET LENGTH
  INC HL                                                  ;MOVE UP TO THE POINTER
  PUSH HL           ; Save pointer to string              ;GET POINTER TO POINTER OF ARG
  CALL TESTR        ; See if enough string space          ;GET THE SPACE
  POP HL            ; Restore pointer to string           ;FIND OUT WHERE STRING TO COPY
  LD C,(HL)         ; Get LSB of address
  INC HL
  LD B,(HL)         ; Get MSB of address                  
  CALL CRTMST       ; Create string entry                 ;SETUP DSCTMP
  PUSH HL           ; Save pointer to MSB of addr         ;SAVE POINTER TO DSCTMP
  LD L,A            ; Length of string                    ;GET CHARACTER COUNT INTO [L]
  CALL TOSTRA       ; Move to string area                 ;MOVE THE CHARS IN
  POP DE            ; Restore pointer to MSB              ;RESTORE POINTER TO DSCTMP
  RET                                                     ;RETURN

; This entry point is used by the routines at __CHR_S and INKEY_S.
STRIN1:
  LD A,$01          ;MAKE ONE CHAR STRING (CHR$, INKEY$)

; Make temporary string
;GET SOME STRING SPACE ([A] CHARS)
;
; Used by the routines at GET_DAY, CONCAT, __SPACE_S and INPUT_S.
MKTMST:
  CALL TESTR			; See if enough string space

; Create temporary string entry
;
; Used by the routines at SAVSTR, DTSTR and __LEFT_S.
CRTMST:
  LD HL,DSCTMP            ; Temporary string              ;GET DESC. TEMP
  PUSH HL                 ; Save it                       ;SAVE DESC. POINTER
  LD (HL),A               ; Save length of string         ;SAVE CHARACTER COUNT
;PUTDEI:
  INC HL                                                  ;STORE [D,E]=POINTER TO FREE SPACE
  LD (HL),E               ; Save LSB of address
  INC HL
  LD (HL),D               ; Save MSB of address
  POP HL                  ; Restore pointer               ;AND RESTORE [H,L] AS THE DESCRIPTOR POINTER
  RET

; Create String
;
; Used by the routines at __PRINT, __STR_S and PRS.
CRTST:
  DEC HL			; DEC - INCed after


;
; STRLT2 TAKES THE STRING LITERAL WHOSE FIRST CHARACTER IS POINTED BY [H,L]+1 AND BUILDS A DESCRIPTOR FOR IT.
; THE DESCRIPTOR IS INITIALLY BUILT IN DSCTMP, BUT PUTNEW TRANSFERS IT INTO A TEMPORARY AND LEAVES A POINTER
; AT THE TEMPORARY IN FACLO. THE CHARACTERS OTHER THAN ZERO THAT TERMINATE THE STRING SHOULD BE SET UP IN [B]
; AND [D]. IT THE TERMINATOR IS A QUOTE, THE QUOTE IS SKIPPED OVER.
; LEADING QUOTES SHOULD BE SKIPPED BEFORE CALL. ON RETURN THE CHARACTER AFTER THE STRING LITERAL IS POINTED TO
; BY [H,L] AND IS IN [A], BUT THE CONDITION CODES ARE NOT SET UP.
;
; Create quote terminated String
;
; Used by the routines at __INPUT and OPRND.
QTSTR:
  LD B,'"'			; Terminating quote              ;ASSUME STR ENDS ON QUOTE
; This entry point is used by the routines at __LINE and L4F2E.
; Eval quoted string
QTSTR_0:
  LD D,B			; Quote to D

; Create String, termination char in D
;
; Used by the routine at __READ.
DTSTR:
  PUSH HL           ; Save start                     ;SAVE POINTER TO START OF LITERAL
  LD C,-1           ; Set counter to -1              ;INITIALIZE CHARACTER COUNT
STRGET:
  INC HL            ; Move on
  LD A,(HL)         ; Get byte                       ;GET CHAR
  INC C             ; Count bytes                    ;BUMP CHARACTER COUNT
  OR A              ; End of line?                   ;IF 0, (END OF LINE) DONE
  JP Z,STRFIN       ; Yes - Create string entry      ;TEST
  CP D              ; Terminator D found?
  JP Z,STRFIN       ; Yes - Create string entry
  CP B              ; Terminator B found?            ;CLOSING QUOTE
  JP NZ,STRGET      ; No - Keep looking              ;NO, GO BACK FOR MORE
STRFIN:            
  CP '"'            ; End with '"'?                  ;IF QUOTE TERMINATES THE STRING
  CALL Z,__CHRGTB   ; Yes - Get next character       ;SKIP OVER THE QUOTE
;------
;  PUSH HL                 ;SAVE POINTER AT END OF STRING
;  LD A,B                  ;WERE WE SCANNING AN UNQUOTED STRING?
;  CP ','
;  JP NZ,NTTRLS            ;IF NOT, DON'T SUPPRESS TRAILING SPACES
;  INC C                   ;FIX [C] WHICH IS THE CHARACTER COUNT
;LPTRLS:
;  DEC C                   ;DECREMENT UNTIL WE FIND A NON-SPACE CHARACTER
;  JP Z,NTTRLS             ;DON'T GO PAST START (ALL SPACES)
;  DEC HL                  ;LOOK AT PREVIOUS CHARACTER
;  LD A,(HL)
;  CP ' '
;  JP Z,LPTRLS             ;IF SO CONTINUE LOOKING
;NTTRLS:
;  POP HL
;-------
  EX (SP),HL        ; Starting quote
  INC HL            ; First byte of string
  EX DE,HL          ; To DE                          ;GET POINTER TO TEMP
  LD A,C            ; Get length                     ;GET CHARACTER COUNT IN A
  CALL CRTMST       ; Create string entry            ;SAVE STR INFO

;
; SOME STRING FUNCTION IS RETURNING A RESULT IN DSCTMP
; WE WANT TO SETUP A TEMP DESCRIPTOR WITH DCSTMP IN IT
; PUT A POINTER TO THE DESCRIPTOR IN FACLO AND FLAG THE 
; RESULT AS TYPE STRING
;

; Temporary string to pool
; a.k.a. PUTNEW
;
; Used by the routines at TIME_S_FN, DATE_S_FN, DAY_S_FN, CONCAT, TOPOOL and
; __LEFT_S.
TSTOPL:
  LD DE,DSCTMP      ; Temporary string                     ;[D,E] POINT AT RESULT DESCRIPTOR
  DEFB $3E          ; "LD A,n" to Mask the next byte       ;SKIP THE NEXT BYTE ("MVI AL,")

PUTTMP:
  PUSH DE                                                  ;SAVE A POINTER TO THE START OF THE STRING
  LD HL,(TEMPPT)	; Temporary string pool pointer        ;[H,L]=POINTER TO FIRST FREE TEMP
  LD (FACLOW),HL	; Save address of string ptr           ;POINTER AT WHERE RESULT DESCRIPTOR WILL BE
  LD A,$03          
  LD (VALTYP),A		; Set type to string                   ;FLAG THIS AS A STRING
  CALL FP2HL        ; Move string to pool                  ;AND MOVE THE VALUE INTO A TEMPORARY
  LD DE,DSCTMP+3                                           ;IF THE CALL IS TO PUTTMP, [D,E] WILL NOT EQUAL DSCTMP +3
  RST CPDEHL        ; Out of string pool?                  ;DSCTMP IS JUST BEYOND THE TEMPS
                                                           ;AND IF TEMPPT POINTS AT IT THERE ARE NO FREE TEMPS
  LD (TEMPPT),HL    ; Save new pointer                     ;SAVE NEW TEMPORARY POINTER
  POP HL            ; Restore code string address          ;GET THE TEXT POINTER
  LD A,(HL)         ; Get next code byte                   ;GET CURRENT CHARACTER INTO [A]
  RET NZ            ; Return if pool OK
  LD DE,$0010		; Err $10 - "String formula too complex"  ; "STRING TEMPORARY" ERROR
  JP ERROR                                                 ;GO TELL HIM

;
; PRINT THE STRING POINTED TO BY [H,L] WHICH ENDS WITH A ZERO
; IF THE STRING IS BELOW DSCTMP IT WILL BE COPIED INTO STRING SPACE
;
; Print number string
PRNUMS:
  INC HL            ;POINT AT NEXT CHARACTER

; Create string entry and print it
;
; Used by the routines at ERESET, READY, __LINE, __READ, CAS_OPNI_CO, LNUM_MSG,
; INXD, USING, TEL_GET_STAT, DWNLDR, PRINT_LINE, TEXT, __EDIT, TXT_CTL_N,
; MOVE_TEXT, BOOT and FREEMEM.
PRS:
  CALL CRTST        ;GET A STRING LITERAL

; Print string at HL
;
; Used by the routines at __PRINT, __INPUT and USING.
PRS1:
  CALL GSTRCU       ;RETURN TEMP POINTER BY FACLO
  CALL LOADFP_0     ;[D]=LENGTH [B,C]=POINTER AT DATA
  INC D             ;INCREMENT AND DECREMENT EARLY TO CHECK FOR NULL STRING
PRS1_0:
  DEC D             ;DECREMENT THE LENGTH
  RET Z             ;ALL DONE
  LD A,(BC)         ;GET CHARACTER TO PRINT
  RST OUTDO
  CP $0D
  CALL Z,CRFIN
  INC BC            ;POINT TO THE NEXT CHARACTER
  JP PRS1_0         ;AND PRINT IT...


; Test if enough room for string
;
; a.k.a. GETSPA - GET SPACE FOR CHARACTER STRING
; MAY FORCE GARBAGE COLLECTION.
;
; # OF CHARS (BYTES) IN [A]
; RETURNS WITH POINTER IN [D,E] OTHERWISE IF CANT GET SPACE
; BLOWS OFF TO "OUT OF STRING SPACE" TYPE ERROR.
;
; Used by the routines at SAVSTR, MKTMST and __LEFT_S.
TESTR:
  OR A              ; MUST BE NON ZERO. SIGNAL NO GARBAG YET
  DEFB $0E          ; "LD C,n" to Mask the next byte

; GRBDON: Garbage Collection Done
GRBDON:
  POP AF                                                ;IN CASE COLLECTED WHAT WAS LENGTH?
  PUSH AF           ; Save status                       ;SAVE IT BACK
  LD HL,(STKTOP)    ; Bottom of string space in use
  EX DE,HL          ; To DE                             ;IN [D,E]
  LD HL,(FRETOP)    ; Bottom of string area             ;GET TOP OF FREE SPACE IN [H,L]
  CPL               ; Negate length (Top down)          ;-# OF CHARS
  LD C,A            ; -Length to BC                     ;IN [B,C]
  LD B,$FF          ; BC = -ve length of string
  ADD HL,BC         ; Add to bottom of space in use     ;SUBTRACT FROM TOP OF FREE
  INC HL            ; Plus one for 2's complement
  RST CPDEHL        ; Below string RAM area?            ;COMPARE THE TWO
  JP C,TESTOS       ; Tidy up if not done else err      ;NOT ENOUGH ROOM FOR STRING, OFFAL TIME
  LD (FRETOP),HL    ; Save new bottom of area           ;SAVE NEW BOTTOM OF MEMORY
  INC HL            ; Point to first byte of string     ;MOVE BACK TO POINT TO STRING
  EX DE,HL          ; Address to DE                     ;RETURN WITH POINTER IN [D,E]

; This entry point is used by the routines at DETOKEN and HL_CSNG.
POPAF:
  POP AF            ; Throw away status push            ;GET CHARACTER COUNT
  RET                                                   ;RETURN FROM GETSPA

; Garbage Collection: Tidy up if not done else err
; a.k.a. GARBAG
; Used by the routine at GRBDON.
TESTOS:
  POP AF            ; Garbage collect been done?           ;HAVE WE COLLECTED BEFORE?
  LD DE,$000E       ; Err $0E - "Out of string space"      ;GET READY FOR OUT OF STRING SPACE ERROR
  JP Z,ERROR        ; Yes - Not enough string apace        ;GO TELL USER HE LOST
  CP A              ; Flag garbage collect done            ;SET ZERO FLAG TO SAY WEVE GARBAGED
  PUSH AF           ; Save status                          ;SAVE FLAG BACK ON STACK
  LD BC,GRBDON      ; Garbage collection done              ;PLACE FOR GARBAG TO RETURN TO.
  PUSH BC           ; Save for RETurn                      ;SAVE ON STACK

; This entry point is used by the routine at __FRE.
GARBGE:
  LD HL,(MEMSIZ)    ; Get end of RAM pointer               ;START FROM TOP DOWN
GARBLP:
  LD (FRETOP),HL    ; Reset string pointer                 ;LIKE SO
  LD HL,$0000                                              ;GET DOUBLE ZERO
  PUSH HL           ; Flag no string found                 ;SAY DIDNT SEE VARS THIS PASS
  LD HL,(STREND)    ; Get bottom of string space           ;FORCE DVARS TO IGNORE STRINGS IN THE PROGRAM TEXT (LITERALS, DATA)
  PUSH HL           ; Save bottom of string space          ;FORCE FIND HIGH ADDRESS
  LD HL,TEMPST      ; Temporary string pool                ;GET START OF STRING TEMPS

; Routine at 10242
TVAR:
  EX DE,HL          ;SAVE IN [D,E]
  LD HL,(TEMPPT)    ;SEE IF DONE     ; Temporary string pool pointer
  EX DE,HL          ;FLIP
  RST CPDEHL        ;TEST            ; Temporary string pool done?

  ;CANNOT RUN IN RAM SINCE IT STORES TO MESS UP BASIC
  LD BC,TVAR        ;FORCE JUMP TO TVAR                       ; Loop until string pool done
  JP NZ,STPOOL      ;DO TEMP VAR GARBAGE COLLECT              ; No - See if in string area
  LD HL,PRMPRV      ;SETUP ITERATION FOR PARAMETER BLOCKS     ; Start of simple variables
  LD (TEMP9),HL     
  LD HL,(VAREND)    ;GET STOPPING POINT IN [H,L]
  LD (ARYTA2),HL    ;STORE IN STOP LOCATION
  LD HL,(VARTAB)    ;GET STARTING POINT IN [H,L]
SMPVAR:
  EX DE,HL
  LD HL,(ARYTA2)    ;GET STOPPING LOCATION                    ; End of simple variables
  EX DE,HL
  RST CPDEHL        ;SEE IF AT END OF SIMPS                   ; All simple strings done?
  JP Z,ARYVAR                                                 ; Yes - Do string arrays
  LD A,(HL)         ;GET VALTYP                               ; Get type of variable
  INC HL            ;BUMP POINTER TWICE
  INC HL            ;
  INC HL            ;POINT AT THE VALUE
  CP $03            ;SEE IF ITS A STRING
  JP NZ,SKPVAR      ;IF NOT, JUST SKIP AROUND IT
  CALL STRADD       ;COLLECT IT                               ; Add if string in string area
  XOR A             ;AND DON'T SKIP ANYTHING MORE
SKPVAR:
  LD E,A
  LD D,$00          ;[D,E]=AMOUNT TO SKIP
  ADD HL,DE
  JP SMPVAR         ;GET NEXT ONE                             ; Loop until simple ones done

ARYVAR:
  LD HL,(TEMP9)     ;GET LINK IN PARAMETER BLOCK CHAIN
  LD E,(HL)         ;GO BACK ONE LEVEL
  INC HL
  LD D,(HL)
  LD A,D
  OR E              ;WAS THAT THE END?
  LD HL,(VAREND)
  JP Z,ARRLP        ;OTHERWISE GARBAGE COLLECT ARRAYS
  EX DE,HL
  LD (TEMP9),HL     ;SETUP NEXT LINK IN CHAIN FOR ITERATION
  INC HL            ;SKIP CHAIN POINTER
  INC HL
  LD E,(HL)         ;PICK UP THE LENGTH
  INC HL
  LD D,(HL)
  INC HL
  EX DE,HL          ;SET [D,E]= ACTUAL END ADDRESS BY
  ADD HL,DE         ;ADDING BASE TO LENGTH
  LD (ARYTA2),HL    ;SET UP STOP LOCATION
  EX DE,HL
  JP SMPVAR

; Move to next array
;
; Used by the routine at ARRLP.
GNXARY:
  POP BC            ; Scrap address of this array         ;GET RID OF STACK GARBAGE

; Used by the routines at TVAR and GRBARY.
ARRLP:
  EX DE,HL                                                ;SAVE ARYVAR IN [D,E]
  LD HL,(STREND)    ; End of string arrays                ;GET END OF ARRAYS
  EX DE,HL                                                ;FLIP BACK
  RST CPDEHL        ; All string arrays done?             ;SEE IF DONE WITH ARRAYS
  JP Z,SCNEND       ; Yes - Move string if found          ;YES, SEE IF DONE COLLECTING
  LD A,(HL)         ; Get type of array                   ;GET THE VALUE TYPE INTO [A]
  INC HL
  CALL LOADFP       ; Get next                            ;SKIP THE EXTRA CHARACTERS
  PUSH HL           ; Save address of num of dim'ns       ;SAVE POINTER TO DIMS
  ADD HL,BC         ; Start of next array                 ;ADD TO CURRENT POINTER PO
  CP $03            ; Test type of array                  ;SEE IF ITS A STRING
  JP NZ,GNXARY      ; Numeric array - Ignore it           ;IF NOT JUST SKIP IT
  LD (TEMP8),HL     ; Save address of next array          ;SAVE END OF ARRAY
  POP HL            ; Get address of num of dim'ns        ;GET BACK CURRENT POSITION
  LD C,(HL)         ; BC = Number of dimensions           ;PICK UP NUMBER OF DIMS
  LD B,$00                                                ;MAKE DOUBLE WITH HIGH ZERO
  ADD HL,BC         ; Two bytes per dimension size        ;GO PAST DIMS
  ADD HL,BC                                               ;BY ADDING ON TWICE #DIMS (2 BYTE GUYS)
  INC HL            ; Plus one for number of dim'ns       ;ONE MORE TO ACCOUNT FOR #DIMS.

; Routine at 10363
ARYSTR:
  EX DE,HL          ;SAVE CURRENT POSIT IN [D,E]          ; Get address of next array
  LD HL,(TEMP8)     ;GET END OF ARRAY
  EX DE,HL          ;FIX [H,L] BACK TO CURRENT            ; Is this array finished?
  RST CPDEHL        ;SEE IF AT END OF ARRAY               ; Yes - Get next one
  JP Z,ARRLP        ;END OF ARRAY, TRY NEXT ARRAY         ; Loop until array all done
  LD BC,ARYSTR      ;ADDR OF WHERE TO RETURN TO

STPOOL:
  PUSH BC           ;GOES ON STACK                        ; Save return address

STRADD:
  XOR A
  OR (HL)           ; Get string length                  ;SEE IF ITS THE NULL STRING
  INC HL
  LD E,(HL)         ; Get LSB of string address
  INC HL
  LD D,(HL)         ; Get MSB of string address
  INC HL                                                 ;[D,E]=POINTER AT THE VALUE
  RET Z                                                  ;NULL STRING, RETURN
  LD B,H                                                 ;MOVE [H,L] TO [B,C]
  LD C,L
  LD HL,(FRETOP)    ; Bottom of new area                 ;GET POINTER TO TOP OF STRING FREE SPACE
  RST CPDEHL        ; String been done?                  ;IS THIS STRINGS POINTER .LT. FRETOP
  LD H,B            ; Restore variable pointer           ;MOVE [B,C] BACK TO [H,L]
  LD L,C
  RET C             ; String done - Ignore               ;IF NOT, NO NEED TO MESS WITH IT FURTHUR
  POP HL            ; Return address                     ;GET RETURN ADDRESS OFF STACK
  EX (SP),HL        ; Lowest available string area       ;GET MAX SEEN SO FAR & SAVE RETURN ADDRESS
  RST CPDEHL        ; String within string area?         ;LETS SEE
  EX (SP),HL        ; Lowest available string area       ;SAVE MAX SEEN & GET RETURN ADDRESS OFF STACK
  PUSH HL           ; Re-save return address             ;SAVE RETURN ADDRESS BACK
  LD H,B            ; Restore variable pointer           ;MOVE [B,C] BACK TO [H,L]
  LD L,C
  RET NC            ; Outside string area - Ignore       ;IF NOT, LETS LOOK AT NEXT VAR
  POP BC            ; Get return , Throw 2 away          ;GET RETURN ADDR OFF STACK
  POP AF                                                 ;POP OFF MAX SEEN
  POP AF                                                 ;AND VARIABLE POINTER
  PUSH HL           ; Save variable pointer              ;SAVE NEW VARIABLE POINTER
  PUSH DE           ; Save address of current            ;AND NEW MAX POINTER
  PUSH BC           ; Put back return address            ;SAVE RETURN ADDRESS BACK
  RET               ; Go to it                           ;AND RETURN

;
; HERE WHEN MADE ONE COMPLETE PASS THRU STRING VARS
;
; All string arrays done, now move string
;
; Used by the routine at ARRLP.
SCNEND:
  POP DE            ; Addresses of strings               ;POP OFF MAX POINTER
  POP HL                                                 ;AND GET VARIABLE POINTER
  LD A,H            ; HL = 0 if no more to do            ;GET LOW IN
  OR L                                                   ;SEE IF ZERO POINTER
  RET Z             ; No more to do - Return             ;IF END OF COLLECTION, THEN MAYBE RETURN TO GETSPA
  DEC HL                                                 ;CURRENTLY JUST PAST THE DESCRIPTOR
  LD B,(HL)         ; MSB of address of string           ;[B]=HIGH BYTE OF DATA POINTER
  DEC HL
  LD C,(HL)         ; LSB of address of string           ;[B,C]=POINTER AT STRING DATA
  PUSH HL           ; Save variable address              ;SAVE THIS LOCATION SO THE POINTER CAN BE UPDATED AFTER THE STRING IS MOVED
  DEC HL
  LD L,(HL)         ; HL = Length of string              ;[L]=STRING LENGTH
  LD H,$00                                               ;[H,L] GET CHARACTER COUNT
  ADD HL,BC         ; Address of end of string+1         ;[H,L]=POINTER BEYOND STRING
  LD D,B            ; String address to DE
  LD E,C                                                 ;[D,E]=ORIGINAL POINTER
  DEC HL            ; Last byte in string                ;DON'T MOVE ONE BEYOND STRING
  LD B,H            ; Address to BC                      ;GET TOP OF STRING IN [B,C]
  LD C,L
  LD HL,(FRETOP)    ; Current bottom of string area      ;GET TOP OF FREE SPACE
  CALL INTEXP_17    ; Move string to new address         ;MOVE STRING
  POP HL            ; Restore variable address           ;GET BACK POINTER TO DESC.
  LD (HL),C         ; Save new LSB of address            ;SAVE FIXED ADDR
  INC HL                                                 ;MOVE POINTER
  LD (HL),B         ; Save new MSB of address            ;HIGH PART
  LD H,B            ; Next string area+1 to HL
  LD L,C                                                 ;[H,L]=NEW POINTER
  DEC HL            ; Next string area address           ;FIX UP FRETOP
  JP GARBLP         ; Look for more strings              ;AND TRY TO FIND HIGH AGAIN


; String concatenation
;
; THE FOLLOWING ROUTINE CONCATENATES TWO STRINGS
; THE FACLO CONTAINS THE FIRST ONE AT THIS POINT,
; [H,L] POINTS BEYOND THE + SIGN AFTER IT
;
; Used by the routine at EVAL3.
CONCAT:
  PUSH BC           ; Save prec' opr & code string       ;PUT OLD PRECEDENCE BACK ON
  PUSH HL                                                ;SAVE TEXT POINTER
  LD HL,(FACLOW)    ; Get first string                   ;GET POINTER TO STRING DESC.
  EX (SP),HL        ; Save first string                  ;SAVE ON STACK & GET TEXT POINTER BACK
  CALL OPRND        ; Get second string                  ;EVALUATE REST OF FORMULA
  EX (SP),HL        ; Restore first string               ;SAVE TEXT POINTER, GET BACK DESC.
  CALL TSTSTR       ; Make sure it's a string
  LD A,(HL)         ; Get length of second string
  PUSH HL           ; Save first string                  ;SAVE DESC. POINTER.
  LD HL,(FACLOW)    ; Get second string                  ;GET POINTER TO 2ND DESC.
  PUSH HL           ; Save second string                 ;SAVE IT
  ADD A,(HL)        ; Add length of second string        ;ADD TWO LENGTHS TOGETHER
  LD DE,$000F       ; Err $0F - "String too long"        ;SEE IF RESULT .LT. 256
  JP C,ERROR        ; String too long - Error            ;ERROR "LONG STRING"
  CALL MKTMST       ; Make temporary string              ;GET INITIAL STRING
  POP DE            ; Get second string to DE            ;GET 2ND DESC.
  CALL GSTRDE       ; Move to string pool if needed
  EX (SP),HL        ; Get first string                   ;SAVE POINTER TO IT
  CALL GSTRHL       ; Move to string pool if needed      ;FREE UP 1ST TEMP
  PUSH HL           ; Save first string                  ;SAVE DESC. POINTER (FIRST)
  LD HL,(TMPSTR)    ; Temporary string address           ;GET POINTER TO FIRST
  EX DE,HL          ; To DE                              ;IN [D,E]
  CALL SSTSA        ; First string to string area        ;MOVE IN THE FIRST STRING
  CALL SSTSA        ; Second string to string area       ;AND THE SECOND
  LD HL,EVAL2       ; Return to evaluation loop          ;CAT REENTERS FORMULA EVALUATION AT EVAL2
  EX (SP),HL        ; Save return,get code string
  PUSH HL           ; Save code string address           ;TEXT POINTER OFF FIRST
  JP TSTOPL         ; To temporary string to pool        ;THEN RETURN ADDRESS OF TSTOP

; Move string on stack to string area
;
; Used by the routine at CONCAT.
SSTSA:
  POP HL            ; Return address                     ;GET RETURN ADDR
  EX (SP),HL        ; Get string block,save return       ;PUT BACK, BUT GET DESC.
  LD A,(HL)         ; Get length of string               ;[A]=STRING LENGTH
  INC HL
  LD C,(HL)         ; Get LSB of string address          ;[B,C]=POINTER AT STRING DATA
  INC HL
  LD B,(HL)         ; Get MSB of string address
  LD L,A            ; Length to L                        ;[L]=STRING LENGTH

; Move string in BC, (len in L) to string area
;
; Used by the routines at SAVSTR and __LEFT_S.
TOSTRA:
  INC L                 ; INC - DECed after

; TOSTRA loop
;
; Used by the routine at MV_MEM.
TSALP:
  DEC L                 ; Count bytes moved                  ;SET CC'S
  RET Z                 ; End of string - Return             ;0, NO BYTE TO MOVE

; Move the memory pointed by BC to the memory pointed by DE, L times.
MV_MEM:
  LD A,(BC)             ; Get source                         ;GET CHAR
  LD (DE),A             ; Save destination                   ;SAVE IT
  INC BC                ; Next source                        ;MOVE POINTERS
  INC DE                ; Next destination
  JP TSALP              ; Loop until string moved            ;KEEP DOING IT


; Get string pointed by FPREG 'Type Error' if it is not
;
; FRETMP IS PASSED A POINTER TO A STRING DESCRIPTOR IN [D,E]
; THIS VALUE IS RETURNED IN [H,L]. ALL THE OTHER REGISTERS ARE MODIFIED.
; A CHECK TO IS MADE TO SEE IF THE STRING DESCRIPTOR [D,E] POINTS TO
; IS THE LAST TEMPORARY DESCRIPTOR ALLOCATED BY PUTNEW.
; IF SO, THE TEMPORARY IS FREED UP BY THE UPDATING OF TEMPPT.
; IF A TEMPORARY IS FREED UP, A FURTHER CHECK IS MADE TO SEE IF THE STRING DATA
; THAT THAT STRING TEMPORARY POINTED TO IS THE THE LOWEST PART OF STRING SPACE IN USE.
; IF SO, FRETMP IS UPDATED TO REFLECT THE FACT THAT THAT SPACE IS NO LONGER IN USE.
;
; Used by the routines at __DAY_S, OUTS_B_CHARS, CAS_OPNI_CO, __LEN, INSTR and
; FNAME.
GETSTR:
  CALL TSTSTR          ; Make sure it's a string

; Get string pointed by FPREG
;
; Used by the routines at __STR_S, PRS1 and __FRE.
; a.k.a. FREFAC
GSTRCU:
  LD HL,(FACLOW)       ; Get current string

; Get string pointed by HL
;
; Used by the routines at CONCAT, INSTR and USING.
GSTRHL:
  EX DE,HL             ; Save DE                            ;FREE UP THE TEMP IN THE FACLO

; Get string pointed by DE
;
; Used by the routines at CAS_OPNI_CO, CONCAT and __LEFT_S.
GSTRDE:
  CALL FRETMS          ; Was it last tmp-str?               ;FREE UP THE TEMPORARY 
  EX DE,HL             ; Restore DE                         ;PUT THE STRING POINTER INTO [H,L]
  RET NZ               ; No - Return
  PUSH DE              ; Save string                        ;SAVE [D,E] TO RETURN IN [H,L]
  LD D,B               ; String block address to DE         ;[D,E]=POINTER AT STRING
  LD E,C               
  DEC DE               ; Point to length                    ;SUBTRACT ONE
  LD C,(HL)            ; Get string length                  ;[C]=LENGTH OF THE STRING FREED UP
  LD HL,(FRETOP)       ; Current bottom of string area      ;SEE IF ITS THE FIRST ONE IN STRING SPACE
  RST CPDEHL           ; Last one in string area?
  JP NZ,POPHL          ; No - Return                        ;NO SO DON'T ADD
  LD B,A               ; Clear B (A=0)                      ;MAKE [B]=0
  ADD HL,BC            ; Remove string from str' area       ;ADD
  LD (FRETOP),HL       ; Save new bottom of str' area       ;AND UPDATE FRETOP
POPHL:
  POP HL               ; Restore string                     ;GET POINTER AT CURRENT DESCRIPTOR
  RET
  
; This entry point is used by the routine at __LET and GSTRDE.
; Back to last tmp-str entry
; a.k.a BAKTMP
FRETMS:
  LD HL,(TEMPPT)       ; Back                               ;GET TEMP POINTER
  DEC HL               ; Get MSB of address                 ;LOOK AT WHAT IS IN THE LAST TEM
  LD B,(HL)            ; Back                               ;[B,C]=POINTER AT STRING
  DEC HL               ; Get LSB of address                 ;DECREMENT TEMPPT BY STRSIZ
  LD C,(HL)            ; Back
  DEC HL               ; Back
  RST CPDEHL           ; String last in string pool?        ;SEE IF [D,E] POINT AT THE LAST 
  RET NZ               ; Yes - Leave it                     ;RETURN NOW IF NOW FREEING DONE
  LD (TEMPPT),HL       ; Save new string pool top           ;UPDATE THE TEMP POINTER SINCE ITS BEEN DECREMENTED BY 4
  RET


; 'LEN' BASIC function
;
; THE FUNCTION LEN($) RETURNS THE LENGTH OF THE
; STRING PASSED AS AN ARGUMENT
;
__LEN:
  LD BC,PASSA          ; To return integer A                ;CALL SNGFLT WHEN DONE
  PUSH BC              ; Save address                       ;LIKE SO

; This entry point is used by the routines at __ASC and __VAL.
GETLEN:
  CALL GETSTR          ; Get string and its length          ;FREE UP TEMP POINTED TO BY FACLO
  XOR A                                                     ;FORCE NUMERIC FLAG
  LD D,A               ; Clear D                            ;SET HIGH OF [D,E] TO ZERO FOR VAL
  LD A,(HL)            ; Get length of string
  OR A                 ; Set status flags                   ;SET CONDITION CODES ON LENGTH
  RET                                                       ;RETURN


; 'ASC' BASIC function
;
; THE FOLLOWING IS THE ASC($) FUNCTION. IT RETURNS AN INTEGER
; WHICH IS THE DECIMAL ASCII EQUIVALENT
;
__ASC:
  LD BC,PASSA          ; To return integer A                ;WHERE TO GO WHEN DONE
  PUSH BC              ; Save address                       ;SAVE RETURN ADDR ON STACK

; This entry point is used by the routine at STRING_S.
__ASC_0:
  CALL GETLEN          ; Get length of string               ;SET UP ORIGINAL STR
  JP Z,FC_ERR          ; Null string - Error                ;NULL STR, BAD ARG.
  INC HL                                                    ;BUMP POINTER
  LD E,(HL)            ; Get LSB of address                 ;[D,E]=POINTER AT STRING DATA
  INC HL
  LD D,(HL)            ; Get MSB of address
  LD A,(DE)            ; Get first byte of string           ;[A]=FIRST CHARACTER
  RET


; 'CHR$' BASIC function
;
; CHR$(#) CREATES A STRING WHICH CONTAINS AS ITS ONLY
; CHARACTER THE ASCII EQUIVALENT OF THE INTEGER ARG (#)
; WHICH MUST BE .LE. 255.
;
__CHR_S:
  CALL STRIN1          ; Make One character temporary string   ;GET STRING IN DSCTMP
  CALL CONINT          ; Make it integer A                     ;GET INTEGER IN RANGE

; This entry point is used by the routine at INKEY_S.
SETSTR:
  LD HL,(TMPSTR)       ; Get address of string              ;GET ADDR OF STR
  LD (HL),E            ; Save character                     ;SAVE ASCII BYTE

; Save in string pool
;
; Used by the routine at __SPACE_S.
TOPOOL:
  POP BC               ; Clean up stack                     ;RETURN TO HIGHER LEVEL & SKIP THE CHKNUM CALL.
  JP TSTOPL            ; Temporary string to pool           ;GO CALL PUTNEW

; STRING$
;
; Used by the routine at NVRFIL.
STRING_S:
  RST CHRGTB           ;GET NEXT CHAR FOLLOWING "STRING$"
  RST SYNCHR           
  DEFB '('             ;MAKE SURE LEFT PAREN
  CALL GETINT          ;EVALUATE FIRST ARG (LENGTH)
  PUSH DE              ;SAVE IT
  RST SYNCHR           
  DEFB ','             ;COMMA
  CALL EVAL            ;GET FORMULA ARG 2
  RST SYNCHR           
  DEFB ')'             ;EXPECT RIGHT PAREN
  EX (SP),HL           ;SAVE TEXT POINTER ON STACK, GET REP FACTOR
  PUSH HL              ;SAVE BACK REP FACTOR
  RST GETYPR           ;GET TYPE OF ARG
  JP Z,STRSTR          ;WAS A STRING
  CALL CONINT          ;GET ASCII VALUE OF CHAR
  JP CALSPA            ;NOW CALL SPACE CODE

STRSTR:
  CALL __ASC_0         ;GET VALUE OF CHAR IN [A]
CALSPA:
  POP DE               ;GET REP FACTOR IN [E]
  CALL __SPACE_S_0     ;INTO SPACE CODE, PUT DUMMY ENTRY ON STACK POPPED OFF BY FINBCK

; SPACE$
__SPACE_S:
  CALL CONINT          ;GET NUMBER OF CHARS IN [E]
  LD A,' '             ;GET SPACE CHAR

; This entry point is used by the routine at STRING_S.
__SPACE_S_0:
  PUSH AF              ;SAVE CHAR
  LD A,E               ;GET NUMBER OF CHARS IN [A]
  CALL MKTMST          ;GET A STRING THAT LONG
  LD B,A               ;COUNT OF CHARS BACK IN [B]
  POP AF               ;GET BACK CHAR TO PUT IN STRING
  INC B                ;TEST FOR NULL STRING
  DEC B
  JP Z,TOPOOL          ;YES, ALL DONE
  LD HL,(TMPSTR)       ;GET DESC. POINTER
SPLP:
  LD (HL),A            ;SAVE CHAR
  INC HL               ;BUMP PTR
  DEC B                ;DECR COUNT
  JP NZ,SPLP           ;KEEP STORING CHAR
  JP TOPOOL            ;PUT TEMP DESC WHEN DONE


; 'LEFT$' BASIC function
;
; THE FOLLOWING IS THE LEFT$($,#) FUNCTION.
; IT TAKES THE LEFTMOST # CHARS OF THE STR.
; IF # IS .GT. THAN THE LEN OF THE STR, IT RETURNS THE WHOLE STR.
;
; LEFT$
__LEFT_S:
  CALL LFRGNM		  ; Get number and ending ")"            ;TEST THE PARAMETERS
  XOR A               ; Start at first byte in string        ;LEFT NEVER CHANGES STRING POINTER
  
; This entry point is used by the routine at __RIGHT_S.
RIGHT1:
  EX (SP),HL          ; Save code string,Get string
  LD C,A              ; Starting position in string

  DEFB $3E            ; "LD A,n" to Mask the next byte       ;SKIP THE NEXT BYTE WITH "MVI A,"

;
; THIS IS PRINT USINGS ENTRY POINT INTO LEFT$
;
__LEFT_S_1:
  PUSH HL             ; Save string block address (twice)    ;THIS IS A DUMMY PUSH TO OFFSET THE EXTRA POP IN PUTNEW

; Continuation of MID$ routine
MID1:
  PUSH HL             ; Save string block address            ;SAVE DESC. FOR  FRETMP
  LD A,(HL)           ; Get length of string                 ;GET STRING LENGTH
  CP B                ; Compare with number given            ;ENTIRE STRING WANTED?
  JP C,ALLFOL         ; All following bytes required         ;IF #CHARS ASKED FOR.GE.LENGTH,YES
  LD A,B              ; Get new length                       ;GET TRUNCATED LENGTH OF STRING
  DEFB $11            ; "LD DE,nn" to skip "LD C,0"          ;SKIP OVER MVI USING "LXI D,"

ALLFOL:
  LD C,0              ; First byte of string                 ;MAKE OFFSET ZERO
  PUSH BC             ; Save position in string              ;SAVE OFFSET ON STACK
  CALL TESTR          ; See if enough string space           ;GET SPACE FOR NEW STRING
  POP BC              ; Get position in string               ;GET BACK OFFSET
  POP HL              ; Restore string block address         ;GET BACK DESC POINTER.
  PUSH HL             ; And re-save it                       ;BUT KEEP ON STACK
  INC HL                                                     ;MOVE TO STRING POINTER FIELD
  LD B,(HL)           ; Get LSB of address                   ;GET POINTER LOW
  INC HL                                                     ;
  LD H,(HL)           ; Get MSB of address                   ;POINTER HIGH
  LD L,B              ; HL = address of string               ;GET LOW IN  L
  LD B,$00            ; BC = starting address                ;GET READY TO ADD OFFSET TO POINTER
  ADD HL,BC           ; Point to that byte                   ;ADD  IT
  LD B,H              ; BC = source string                   ;GET OFFSET POINTER IN [B,C]
  LD C,L
  CALL CRTMST         ; Create a string entry                ;SAVE INFO IN DSCTMP
  LD L,A              ; Length of new string                 ;GET#  OF CHARS TO  MOVE IN L
  CALL TOSTRA         ; Move string to string area           ;MOVE THEM IN
  POP DE              ; Clear stack                          ;GET BACK DESC. POINTER
  CALL GSTRDE         ; Move to string pool if needed        ;FREE IT UP.
  JP TSTOPL           ; Temporary string to pool             ;PUT TEMP IN TEMP LIST


; 'RIGHT$' BASIC function
__RIGHT_S:
  CALL LFRGNM         ; Get number and ending ")"            ;CHECK ARG
  POP DE              ; Get string length                    ;GET DESC. POINTER
  PUSH DE             ; And re-save                          ;SAVE BACK FOR LEFT
  LD A,(DE)           ; Get length                           ;GET PRESENT LEN OF STR
  SUB B               ; Move back N bytes                    ;SUBTRACT 2ND PARM
  JP RIGHT1           ; Go and get sub-string                ;CONTINUE WITH LEFT CODE


; 'MID$' BASIC function
;
; MID ($,#) RETURNS STR WITH CHARS FROM # POSITION
; ONWARD. IF # IS GT LEN($) THEN RETURN NULL STRING.
; MID ($,#,#) RETURNS STR WITH CHARS FROM # POSITION
; FOR #2 CHARS. IF #2 GOES PAST END OF STRING, RETURN
; AS MUCH AS POSSIBLE.
;
__MID_S:
  EX DE,HL              ; Get code string address              ;PUT THE TEXT POINTER IN [H,L]
  LD A,(HL)             ; Get next byte "," or ")"             ;GET THE FIRST CHARACTER
  CALL MIDNUM           ; Get number supplied                  ;GET OFFSET OFF STACK AND MAKE
  INC B                 ; Is it character zero?
  DEC B                                                        ;SEE IF EQUAL TO ZERO
  JP Z,FC_ERR           ; Yes - Error                          ;IT MUST NOT BE 0 SURE DOES NOT = 0.
  PUSH BC               ; Save starting position               ;PUT OFFSET ON TO THE STACK
  CALL MID_ARGSEP		; test ',' & ')'                       ;DUPLICATE OF CODE CONDITIONED OUT BELOW
  POP AF                ; Restore starting position            ;GET OFFSET BACK IN A
  EX (SP),HL            ; Get string,save code string          ;SAVE TEXT POINTER, GET DESC.
  LD BC,MID1            ; Continuation of MID$ routine         ;WHERE TO RETURN TO.
  PUSH BC               ; Save for return                      ;GOES ON STACK
  DEC A                 ; Starting position-1                  ;SUB ONE FROM OFFSET
  CP (HL)               ; Compare with length                  ;POINTER PAST END OF STR?
  LD B,$00              ; Zero bytes length                    ;ASSUME NULL LENGTH STR
  RET NC                ; Null string if start past end        ;YES, JUST USE NULL STR
  LD C,A                ; Save starting position-1             ;SAVE OFFSET OF CHARACTER POINTER
  LD A,(HL)             ; Get length of string                 ;GET PRESENT LEN OF STR
  SUB C                 ; Subtract start                       ;SUBTRACT INDEX (2ND ARG)
  CP E                  ; Enough string for it?                ;IS IT TRUNCATION
  LD B,A                ; Save maximum length available        ;GET CALCED LENGTH IN B
  RET C                 ; Truncate string if needed            ;IF NOT USE PARTIAL STR
  LD B,E                ; Set specified length                 ;USE TRUNCATED LENGTH
  RET                   ; Go and create string                 ;RETURN TO LEFT2


; 'VAL' BASIC function
;
; THE VAL FUNCTION TAKES A STRING AND TURN IT INTO
; A NUMBER BY INTERPRETING THE ASCII DIGITS. ETC..
; EXCEPT FOR THE PROBLEM THAT A TERMINATOR MUST BE SUPPLIED
; BY REPLACING THE CHARACTER BEYOND THE STRING, VAL
; IS MERELY A CALL TO FLOATING INPUT (FIN).
;
__VAL:
  CALL GETLEN           ; Get length of string                 ;DO SETUP, SET RESULT=REAL
  JP Z,PASSA            ; Result zero                          ;MAKE SURE TYPE SET UP OK IN EXTENDED
  LD E,A                ; Save length                          ;GET LENGTH OF STR
  INC HL                                                       ;TO HANDLE THE FACT THE IF
  LD A,(HL)             ; Get LSB of address
  INC HL                
  LD H,(HL)             ; Get MSB of address                   ;TWO STRINGS "1" AND "2"
  LD L,A                ; HL = String address                  ;ARE STORED NEXT TO EACH OTHER
  PUSH HL               ; Save string address                  ;AND FIN IS CALLED POINTING TO
  ADD HL,DE                                                    ;THE FIRST TWELVE WILL BE RETURNED
  LD B,(HL)             ; Get end of string+1 byte
  LD (VLZADR),HL                                               
  LD A,B                                                       
  LD (VLZDAT),A         
  LD (HL),D             ; Zero it to terminate                 ;THE IDEA IS TO STORE 0 IN THE
                                                               ;STRING BEYOND THE ONE VAL
                                                               ;IS BEING CALLED ON
  EX (SP),HL            ; Save string end,get start
  PUSH BC               ; Save end+1 byte                      ;THE FIRST CHARACTER OF THE NEXT STRING
  DEC HL                                                       ;***CALL CHRGET TO MAKE SURE
  RST CHRGTB			                                       ;VAL(" -3")=-3
  CALL FIN_DBL          ; Convert ASCII string to FP           ;IN EXTENDED, GET ALL THE PRECISION WE CAN
  LD HL,$0000           
  LD (VLZADR),HL        
  POP BC                ; Restore end+1 byte                   ;GET THE MODIFIED CHARACTER OF THE NEXT STRING INTO [B]
  POP HL                ; Restore end+1 address                ;GET THE POINTER TO THE MODIFIED CHARACTER
  LD (HL),B             ; Put back original byte               ;RESTORE THE CHARACTER

					;IF STRING IS HIGHEST IN STRING SPACE
					;WE ARE MODIFYING [MEMSIZ] AND
					;THIS IS WHY [MEMSIZ] CAN'T BE USED TO STORE
					;STRING DATA BECAUSE WHAT IF THE
					;USER TOOK VAL OFF THAT HIGH STRING
  RET



; Get number, check for ending ')'
; Used by the routines at __LEFT_S and __RIGHT_S.
; USED BY RIGHT$ AND LEFT$ FOR PARAMETER CHECKING AND SETUP
LFRGNM:
  EX DE,HL          ; Code string address to HL            ;PUT THE TEXT POINTER IN [H,L]
  RST SYNCHR 		; Make sure ")" follows                ;PARAM LIST SHOULD END
  DEFB ')'

; Get numeric argument for MID$
; USED BY MID$ FOR PARAMETER CHECKING AND SETUP
MIDNUM:
  POP BC            ; Get return address                   ;GET RETURN ADDR OFF STACK
  POP DE            ; Get number supplied                  ;GET LENGTH OF ARG OFF STACK
  PUSH BC           ; Re-save return address               ;SAVE RETURN ADDR BACK ON
  LD B,E            ; Number to B                          ;SAVE INIT LENGTH
  RET

; INSTR
;
; THIS IS THE INSTR FUCNTION. IT TAKES ONE OF TWO
; FORMS: INSTR(I%,S1$,S2$) OR INSTR(S1$,S2$)
; IN THE FIRST FORM THE STRING S1$ IS SEARCHED FOR THE
; CHARACTER S2$ STARTING AT CHARACTER POSITION I%.
; THE SECOND FORM IS IDENTICAL, EXCEPT THAT THE SEARCH
; STARTS AT POSITION 1. INSTR RETURNS THE CHARACTER
; POSITION OF THE FIRST OCCURANCE OF S2$ IN S1$.
; IF S1$ IS NULL, 0 IS RETURNED. IF S2$ IS NULL, THEN
; I% IS RETURNED, UNLESS I% .GT. LEN(S1$) IN WHICH
; CASE 0 IS RETURNED.
;
; Used by the routine at NVRFIL.
INSTR:
  RST CHRGTB         ;EAT FIRST CHAR
  CALL OPNPAR        ;EVALUATE FIRST ARG
  RST GETYPR         ;SET ZERO IF ARG A STRING.
  LD A,$01           ;IF SO, ASSUME, SEARCH STARTS AT FIRST CHAR
  PUSH AF            ;SAVE OFFSET IN CASE STRING
  JP Z,INSTR_0       ;WAS A STRING
  POP AF             ;GET RID OF SAVED OFFSET
  CALL CONINT        ;FORCE ARG1 (I%) TO BE INTEGER
  OR A               ;DONT ALLOW ZERO OFFSET
  JP Z,FC_ERR        ;KILL HIM.
  PUSH AF            ;SAVE FOR LATER
  RST SYNCHR         
  DEFB ','           ;EAT THE COMMA
  CALL EVAL          ;EAT FIRST STRING ARG
  CALL TSTSTR        ;BLOW UP IF NOT STRING
INSTR_0:             
  RST SYNCHR         
  DEFB ','           ;EAT COMMA AFTER ARG
  PUSH HL            ;SAVE THE TEXT POINTER
  LD HL,(FACLOW)     ;GET DESCRIPTOR POINTER
  EX (SP),HL         ;PUT ON STACK & GET BACK TEXT PNT.
  CALL EVAL          ;GET LAST ARG
  RST SYNCHR         
  DEFB ')'           ;EAT RIGHT PAREN
  PUSH HL            ;SAVE TEXT POINTER
  CALL GETSTR        ;FREE UP TEMP & CHECK STRING
  EX DE,HL           ;SAVE 2ND DESC. POINTER IN [D,E]
  POP BC             ;GET TEXT POINTER IN B
  POP HL             ;DESC. POINTER FOR S1$
  POP AF             ;OFFSET
  PUSH BC            ;PUT TEXT POINTER ON BOTTOM
  LD BC,POPHLRT      ;PUT ADDRESS OF POP H, RET ON
  PUSH BC            ;PUSH IT
  LD BC,PASSA        ;NOW ADDRESS OF [A] RETURNER
  PUSH BC            ;ONTO STACK
  PUSH AF            ;SAVE OFFSET BACK
  PUSH DE            ;SAVE DESC. OF S2
  CALL GSTRHL        ;FREE UP S1 DESC.
  POP DE             ;RESTORE DESC. S2
  POP AF             ;GET BACK OFFSET
  LD B,A             ;SAVE UNMODIFIED OFFSET
  DEC A              ;MAKE OFFSET OK
  LD C,A             ;SAVE IN C
  CP (HL)            ;IS IT BEYOND LENGTH OF S1?
  LD A,$00           ;IF SO, RETURN ZERO. (ERROR)
  RET NC             
  LD A,(DE)          ;GET LENGTH OF S2$
  OR A               ;NULL??
  LD A,B             ;GET OFFSET BACK
  RET Z              ;ALL IF S2 NULL, RETURN OFFSET
  LD A,(HL)          ;GET LENGTH OF S1$
  INC HL             ;BUMP POINTER
  LD B,(HL)          ;GET 1ST BYTE OF ADDRESS
  INC HL             ;BUMP POINTER
  LD H,(HL)          ;GET 2ND BYTE
  LD L,B             ;GET 1ST BYTE SET UP
  LD B,$00           ;GET READY FOR DAD
  ADD HL,BC          ;NOW INDEXING INTO STRING
  SUB C              ;MAKE LENGTH OF STRING S1$ RIGHT
  LD B,A             ;SAVE LENGTH OF 1ST STRING IN [B]
  PUSH BC            ;SAVE COUNTER, OFFSET
  PUSH DE            ;PUT 2ND DESC (S2$) ON STACK
  EX (SP),HL         ;GET 2ND DESC. POINTER
  LD C,(HL)          ;SET UP LENGTH
  INC HL             ;BUMP POINTER
  LD E,(HL)          ;GET FIRST BYTE OF ADDRESS
  INC HL             ;BUMP POINTER AGAIN
  LD D,(HL)          ;GET 2ND BYTE
  POP HL             ;RESTORE POINTER FOR 1ST STRING
CHK1:                
  PUSH HL            ;SAVE POSITION IN SEARCH STRING
  PUSH DE            ;SAVE START OF SUBSTRING
  PUSH BC            ;SAVE WHERE WE STARTED SEARCH
CHK:                 
  LD A,(DE)          ;GET CHAR FROM SUBSTRING
  CP (HL)            ; = CHAR POINTER TO BY [H,L]
  JP NZ,OHWELL       ;NO
  INC DE             ;BUMP COMPARE POINTER
  DEC C              ;END OF SEARCH STRING?
  JP Z,GOTSTR        ;WE FOUND IT!
  INC HL             ;BUMP POINTER INTO STRING BEING SEARCHED
  DEC B              ;DECREMENT LENGTH OF SEARCH STRING
  JP NZ,CHK          
  POP DE             ;END OF STRING, YOU LOSE
  POP DE             ;GET RID OF POINTERS
  POP BC             ;GET RID OF GARB
RETZER:              
  POP DE             ;LIKE SO
  XOR A              ;GO TO SNGFLT.
  RET                ;RETURN

GOTSTR:              
  POP HL             
  POP DE             ;GET RID OF GARB
  POP DE             ;GET RID OF EXCESS STACK
  POP BC             ;GET COUNTER, OFFSET
  LD A,B             ;GET ORIGINAL SOURCE COUNTER
  SUB H              ;SUBTRACT FINAL COUNTER
  ADD A,C            ;ADD ORIGINAL OFFSET (N1%)
  INC A              ;MAKE OFFSET OF ZERO = POSIT 1
  RET                ;DONE

OHWELL:              
  POP BC             
  POP DE             ;POINT TO START OF SUBSTRING
  POP HL             ;GET BACK WHERE WE STARTED TO COMPARE
  INC HL             ;AND POINT TO NEXT CHAR
  DEC B              ;DECR. # CHAR LEFT IN SOURCE STRING
  JP NZ,CHK1         ;TRY SEARCHING SOME MORE
  JP RETZER          ;END OF STRING, RETURN 0


; STRING FUNCTIONS - LEFT HAND SIDE MID$
; This entry point is used by the routine at ID_ERR.
LHSMID:
  RST SYNCHR
  DEFB '('           ;MUST HAVE ( 
  CALL GETVAR        ;GET A STRING VAR
  CALL TSTSTR        ;MAKE SURE IT WAS A STRING
  PUSH HL            ;SAVE TEXT POINTER
  PUSH DE            ;SAVE DESC. POINTER
  EX DE,HL           ;PUT DESC. POINTER IN [H,L]
  INC HL             ;MOVE TO ADDRESS FIELD
  LD E,(HL)          ;GET ADDRESS OF LHS IN [D,E]
  INC HL             ;BUMP DESC. POINTER
  LD D,(HL)          ;PICK UP HIGH BYTE OF ADDRESS
  LD HL,(STREND)     ;SEE IF LHS STRING IS IN STRING SPACE
  RST CPDEHL         ;BY COMPARING IT WITH STKTOP
  JP C,NCPMID        ;IF ALREADY IN STRING SPACE DONT COPY.

             ;9/23/79 Allow MID$ on field strings
  LD HL,(BASTXT)
  RST CPDEHL         ;Is this a fielded string?
  JP NC,NCPMID       ;Yes, Don't copy!!
  POP HL             ;GET BACK DESC. POINTER
  PUSH HL            ;SAVE BACK ON STACK
  CALL STRCPY        ;COPY THE STRING LITERAL INTO STRING SPACE
  POP HL             ;GET BACK DESC. POINTER
  PUSH HL            ;BACK ON STACK AGAIN
  CALL FP2HL         ;MOVE NEW DESC. INTO OLD SLOT.
NCPMID:
  POP HL             ;GET DESC. POINTER
  EX (SP),HL         ;GET TEXT POINTER TO [H,L] DESC. TO STACK
  RST SYNCHR
  DEFB ','           ;MUST HAVE COMMA
  CALL GETINT        ;GET ARG#2 (OFFSET INTO STRING)
  OR A               ;MAKE SURE NOT ZERO
  JP Z,FC_ERR        ;BLOW HIM UP IF ZERO
  PUSH AF            ;SAVE ARG#2 ON STACK
  LD A,(HL)          ;RESTORE CURRENT CHAR
  CALL MID_ARGSEP    ;USE MID$ CODE TO EVALUATE POSIBLE THIRD ARG.
  PUSH DE            ;SAVE THIRD ARG ([E]) ON STACK
  CALL FRMEQL        ;MUST HAVE = SIGN, EVALUATE RHS OF THING.
  PUSH HL            ;SAVE TEXT POINTER.
  CALL GETSTR        ;FREE UP TEMP RHS IF ANY.
  EX DE,HL           ;PUT RHS DESC. POINTER IN [D,E]
  POP HL             ;TEXT POINTER TO [H,L]
  POP BC             ;ARG #3 TO C.
  POP AF             ;ARG #2 TO A.
  LD B,A             ;AND [B]
  EX (SP),HL         ;GET LHS DESC. POINTER TO [H,L] <> TEXT POINTER TO STACK
  PUSH HL            ;SAVE TEXT POINTER
  LD HL,POPHLRT      ;GET ADDR TO RETURN TO
  EX (SP),HL         ;SAVE ON STACK & GET BACK TXT PTR.
  LD A,C             ;GET ARG #3
  OR A               ;SET CC'S
  RET Z              ;IF ZERO, DO NOTHING
  LD A,(HL)          ;GET LENGTH OF LHS
  SUB B              ;SEE HOW MANY CHARS IN EMAINDER OF STRING
  JP C,FC_ERR        ;CANT ASSIGN PAST LEN(LHS)!
  INC A              ;MAKE PROPER COUNT
  CP C               ;SEE IF # OF CHARS IS .GT. THIRD ARG
  JP C,BIGLEN        ;IF SO, DONT TRUNCATE
  LD A,C             ;TRUNCATE BY USING 3RD ARG.
BIGLEN:              
  LD C,B             ;GET OFFSET OF STRING IN [C]
  DEC C              ;MAKE PROPER OFFSET
  LD B,$00           ;SET UP [B,C] FOR LATER DAD B.
  PUSH DE            ;SAVE [D,E]
  INC HL             ;POINTER TO ADDRESS FIELD.
  LD E,(HL)          ;GET LOW BYTE IN [E]
  INC HL             ;BUMP POINTER
  LD H,(HL)          ;GET HIGH BYTE IN [H]
  LD L,E             ;NOW COPY LOW BYTE BACK TO [L]
  ADD HL,BC          ;ADD OFFSET
  LD B,A             ;SET COUNT OF LHS IN [B]
  POP DE             ;RESTORE [D,E]
  EX DE,HL           ;MOVE RHS. DESC. POINTER TO [H,L]
  LD C,(HL)          ;GET LEN(RHS) IN [C]
  INC HL             ;MOVE POINTER
  LD A,(HL)          ;GET LOW BYTE OF ADDRESS IN [A]
  INC HL             ;BUMP POINTER.
  LD H,(HL)          ;GET HIGH BYTE OF ADDRESS IN [H]
  LD L,A             ;COPY LOW BYTE TO [L]
  EX DE,HL           ;ADDRESS OF RHS NOW IN [D,E]
  LD A,C             ;IS RHS NULL?
  OR A               ;TEST
  RET Z              ;THEN ALL DONE.

; NOW ALL SET UP FOR ASSIGNMENT.
; [H,L] = LHS POINTER
; [D,E] = RHS POINTER
; C = LEN(RHS)
; B = LEN(LHS)

MID_LP:
  LD A,(DE)          ;GET BYTE FROM RHS.
  LD (HL),A          ;STORE IN LHS
  INC DE             ;BUMP RHS POINTER
  INC HL             ;BUMP LHS POINTER.
  DEC C              ;BUMP DOWN COUNT OF RHS.
  RET Z              ;IF ZERO, ALL DONE.
  DEC B              ;IF LHS ENDED, ALSO DONE.
  JP NZ,MID_LP       ;IF NOT DONE, MORE COPYING.
  RET                ;BACK TO NEWSTT
  
; This entry point is used by the routine at __MID_S.
; Test ',' & ')' as argument separators in string functions
MID_ARGSEP:
  LD E,255               ;IF TWO ARG GUY, TRUNCATE.
  CP ')'                 
  JP Z,MID_ARGSEP_0      ;[E] SAYS USE ALL CHARS
                         ;IF ONE ARGUMENT THIS IS CORRECT
  RST SYNCHR             
  DEFB ','               ;COMMA? MUST DELINEATE 3RD ARG.
  CALL GETINT            ;GET ARGUMENT  IN  [E]
MID_ARGSEP_0:            
  RST SYNCHR             
  DEFB ')'               ;MUST BE FOLLOWED BY )
  RET                    ;ALL DONE.

; FRE
__FRE:
  LD HL,(STREND)
  EX DE,HL
  LD HL,$0000
  ADD HL,SP
  RST GETYPR
  JP NZ,GIVDBL
  CALL GSTRCU            ;FREE UP ARGUMENT AND SETUP TO GIVE FREE STRING SPACE
  CALL GARBGE            ;DO GARBAGE COLLECTION
  EX DE,HL
  LD HL,(STKTOP)
  EX DE,HL
  LD HL,(FRETOP)         ;TOP OF FREE AREA
  JP GIVDBL              ;RETURN [H,L]-[D,E]

; Double precision subtract (FAC1=FAC1-ARG).
;
; Used by the routines at __SIN, __ATN, __EXP and __RND.
DECSUB:
  LD HL,ARG
  LD A,(HL)
  OR A
  RET Z
  XOR $80
  LD (HL),A
  JP DECADD_0
; This entry point is used by the routine at __NEXT.
DECSUB_0:
  CALL HL_ARG

; Double precision addition (FAC1=FAC1+ARG)
;
; Used by the routines at __LOG, __SQR, __EXP, __RND, NEGAFT, __INT and FLOAT_ADD.
DECADD:
  LD HL,ARG             ; Get FP exponent
  LD A,(HL)             ; Is number zero?
  OR A                  ; Yes - Nothing to add
  RET Z
; This entry point is used by the routine at DECSUB.
DECADD_0:
  AND $7F
  LD B,A
  LD DE,FACCU
  LD A,(DE)             ; Get FPREG exponent
  OR A                  ; Is this number zero?
  JP Z,FP_ARG2DE        ; Yes - Move FP to FPREG
  AND $7F               
  SUB B                 ; FP number larger?
  JP NC,NOSWAP_DEC      ; No - Don't swap them
  CPL                   ; Two's complement
  INC A                 ;  FP exponent
  PUSH AF
  PUSH HL
  LD B,$08			; DBL number, 8 bytes
DECADD_SWAP:
  LD A,(DE)
  LD C,(HL)
  LD (HL),A
  LD A,C
  LD (DE),A
  INC DE
  INC HL
  DEC B
  JP NZ,DECADD_SWAP
  POP HL
  POP AF
NOSWAP_DEC:
  CP $10                    ; Second number insignificant?
  RET NC                    ; Yes - First number is result
  PUSH AF                   ; Save number of bits to scale
  XOR A
  LD (FACCU+8),A
  LD (ARG+8),A              ; Save sign of result
  LD HL,ARG+1               ; Point to FPREG
  POP AF                    ; Restore scaling factor
  CALL SCALE_DEC            ; Set MSBs & sign of result
  LD HL,ARG
  LD A,(FACCU)
  XOR (HL)                  ; Result to be positive?
  JP M,MINCDE_DEC             ; No - Subtract FPREG from CDE
  LD A,(ARG+8)              ; Restore sign of result
  LD (FACCU+8),A
  CALL _BCDADD              ; Add FPREG to CDE
  JP NC,DECROU              ; No overflow - Round it up
  EX DE,HL                  ; Point to exponent
  LD A,(HL)
  INC (HL)                  ; Increment it
  XOR (HL)
  JP M,OV_ERR               ; Number overflowed - Error
  CALL SHRT1_DEC            ; Shift result right
  LD A,(HL)
  OR $10
  LD (HL),A
  JP DECROU                 ; Round it up

MINCDE_DEC:
  CALL BCDSUB
  
; This entry point is used by the routines at DECMUL and __RND.
; Single precision normalization
DECNRM:
  LD HL,FACCU+1
  LD BC,$0800		; 2048
DECNRM_0:
  LD A,(HL)
  OR A
  JP NZ,DECNRM_1
  INC HL
  DEC C
  DEC C
  DEC B
  JP NZ,DECNRM_0
  JP ZERO_EXPONENT

DECNRM_1:
  AND $F0
  JP NZ,DECADD_7
  PUSH HL
  CALL ML16FACCU	; shift 4 bits left the whole accumulator (multiply by 16)
  POP HL
  DEC C
DECADD_7:
  LD A,$08
  SUB B
  JP Z,DECADD_9
  PUSH AF
  PUSH BC
  LD C,B
  LD DE,FACCU+1
  CALL LDIR_C_BYTES
  POP BC
  POP AF
  LD B,A
  XOR A
DECADD_8:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,DECADD_8
DECADD_9:
  LD A,C
  OR A
  JP Z,DECROU
  LD HL,FACCU
  LD B,(HL)
  ADD A,(HL)
  LD (HL),A
  XOR B
  JP M,OV_ERR
  RET Z

; This entry point is used by the routine at _ASCTFP.
DECROU:
  LD HL,FACCU+8
  LD B,$07
; This entry point is used by the routines at __CSNG and PUFOUT.
BNORM_8:
  LD A,(HL)
  CP $50
  RET C
  DEC HL
  XOR A
  SCF
DECADD_SWAP2:
  ADC A,(HL)
  DAA
  LD (HL),A
  RET NC
  DEC HL
  DEC B
  JP NZ,DECADD_SWAP2
  LD A,(HL)
  INC (HL)
  XOR (HL)
  JP M,OV_ERR
  INC HL
  LD (HL),$10
  RET

_BCDADD:
  LD HL,ARG+7
  LD DE,FACCU+7
  LD B,$07
; This entry point is used by the routines at DECMUL and DECDIV.
DAA_PASS2:
  XOR A

; Add the BCD number in (HL) to (DE).  Result in (DE)
BCDADD:
  LD A,(DE)
  ADC A,(HL)
  DAA
  LD (DE),A
  DEC DE
  DEC HL
  DEC B
  JP NZ,BCDADD
  RET

; This entry point is used by the routine at DECADD.
; Subtract the BCD number in (HL) from (DE).
BCDSUB:
  LD HL,ARG+8
  LD A,(HL)
  CP $50
  JP NZ,BCDADD_1
  INC (HL)
BCDADD_1:
  LD DE,FACCU+8
  LD B,$08
  SCF
BCDADD_2:
  LD A,$99
  ADC A,$00
  SUB (HL)
  LD C,A
  LD A,(DE)
  ADD A,C
  DAA
  LD (DE),A
  DEC DE
  DEC HL
  DEC B
  JP NZ,BCDADD_2
  RET C
  EX DE,HL
  LD A,(HL)
  XOR $80
  LD (HL),A
  LD HL,FACCU+8
  LD B,$08
  XOR A
BCDADD_3:
  LD A,$9A
  SBC A,(HL)
  ADC A,$00
  DAA
  CCF
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,BCDADD_3
  RET

; This entry point is used by the routine at DECADD.
ML16FACCU:
  LD HL,FACCU+8
; This entry point is used by the routine at DECDIV.
BCDADD_5:
  PUSH BC
  LD D,B
  LD C,$04
BCDADD_6:
  PUSH HL
  OR A
BCDADD_7:
  LD A,(HL)
  RLA
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,BCDADD_7
  LD B,D
  POP HL
  DEC C
  JP NZ,BCDADD_6
  POP BC
  RET

; This entry point is used by the routine at DECADD.
SCALE_DEC:
  OR A
  RRA
  PUSH AF
  OR A
  JP Z,SHRT1_DEC_0
  PUSH AF
  CPL
  INC A
  LD C,A
  LD B,$FF
  LD DE,$0007
  ADD HL,DE
  LD D,H
  LD E,L
  ADD HL,BC
  LD A,$08
  ADD A,C
  LD C,A
  PUSH BC
  CALL LDIR_C
  POP BC
  POP AF
  INC HL
  INC DE
  PUSH DE
  LD B,A
  XOR A
BCDADD_9:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,BCDADD_9
  POP HL
  POP AF
  RET NC
  LD A,C
BCDADD_10:
  PUSH BC
  PUSH DE
  LD D,A
  LD C,$04
BCDADD_11:
  LD B,D
  PUSH HL
  OR A
BCDADD_12:
  LD A,(HL)
  RRA
  LD (HL),A
  INC HL
  DEC B
  JP NZ,BCDADD_12
  POP HL
  DEC C
  JP NZ,BCDADD_11
  POP DE
  POP BC
  RET

; This entry point is used by the routines at DECADD and PUFOUT.
SHRT1_DEC:
  LD HL,FACCU+1
SHRT1_DEC_LP:
  LD A,$08
  JP BCDADD_10

SHRT1_DEC_0:
  POP AF
  RET NC
  JP SHRT1_DEC_LP

; Double precision multiply (FAC1=FAC1*ARG)
;
; Used by the routines at __LOG, MULPHL, NEGAFT, FMULT and DECEXP.
DECMUL:
  RST TSTSGN
  RET Z
  LD A,(ARG)
  OR A
  JP Z,ZERO_EXPONENT
  LD B,A
  LD HL,FACCU
  XOR (HL)
  AND $80
  LD C,A
  LD A,B
  AND $7F
  LD B,A
  LD A,(HL)
  AND $7F
  ADD A,B
  LD B,A
  LD (HL),$00
  AND $C0
  RET Z
  CP $C0
  JP NZ,DECMUL_0
  JP OV_ERR

DECMUL_0:
  LD A,B
  ADD A,$40
  AND $7F
  RET Z
  OR C
  DEC HL
  LD (HL),A
  LD DE,HOLD+7
  LD BC,SYNCHR
  LD HL,FACCU+7
  PUSH DE
  CALL LDIR_C
  INC HL
  XOR A

  LD B,$08

; Init FP accumulator to zero
DECMUL_1:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,DECMUL_1

  POP DE
  LD BC,NORMALIZE
  PUSH BC
; This entry point is used by the routine at __RND.
DECMUL_2:
  CALL DAA_PASS1
  PUSH HL
  LD BC,SYNCHR
  EX DE,HL
  CALL LDIR_C
  EX DE,HL
  LD HL,HOLD2+7
  LD B,$08
  CALL DAA_PASS2
  POP DE
  CALL DAA_PASS1
  LD C,$07
  LD DE,ARG+7
DECMUL_3:
  LD A,(DE)
  OR A
  JP NZ,DECMUL_4
  DEC DE
  DEC C
  JP DECMUL_3

DECMUL_4:
  LD A,(DE)
  DEC DE
  PUSH DE
  LD HL,HOLD8+7
DECMUL_5:
  ADD A,A
  JP C,DECMUL_7
  JP Z,DECMUL_8
DECMUL_6:
  LD DE,SYNCHR
  ADD HL,DE
  JP DECMUL_5

DECMUL_7:
  PUSH AF
  LD B,$08
  LD DE,FACCU+7
  PUSH HL
  CALL DAA_PASS2
  POP HL
  POP AF
  JP DECMUL_6

DECMUL_8:
  LD B,$0F
  LD DE,FACCU+14	; some declaration is missing here but the distances between
  LD HL,FACCU+15	; the labels in this work area is the same on all the target computers
  CALL LDDR_DEHL
  LD (HL),$00
  POP DE
  DEC C
  JP NZ,DECMUL_4
  RET

; This entry point is used by the routine at DECDIV.
NORMALIZE:
  DEC HL
  LD A,(HL)
  INC HL
  LD (HL),A
  JP DECNRM		; Single precision normalization
  
DAA_PASS1:
  LD HL,$FFF8		; -8
  ADD HL,DE
  LD C,$03
DECMUL_11:
  LD B,$08
  OR A
DECMUL_12:
  LD A,(DE)
  ADC A,A
  DAA
  LD (HL),A
  DEC HL
  DEC DE
  DEC B
  JP NZ,DECMUL_12
  DEC C
  JP NZ,DECMUL_11
  RET

; Double precision DIVIDE
;
; Used by the routines at __TAN, __ATN, __LOG, __SQR, __EXP, MULPHL, FDIV
; and INTEXP.
DECDIV:
  LD A,(ARG)
  OR A
  JP Z,O_ERR
  LD B,A
  LD HL,FACCU
  LD A,(HL)
  OR A
  JP Z,ZERO_EXPONENT
  XOR B
  AND $80
  LD C,A
  LD A,B
  AND $7F
  LD B,A
  LD A,(HL)
  AND $7F
  SUB B
  LD B,A
  RRA
  XOR B
  AND $40
  LD (HL),$00
  JP Z,DECDIV_1
  LD A,B
  AND $80
  RET NZ
DECDIV_0:
  JP OV_ERR

DECDIV_1:
  LD A,B
  ADD A,$41
  AND $7F
  LD (HL),A
  JP Z,DECDIV_0
  OR C
  LD (HL),$00
  DEC HL
  LD (HL),A
  LD DE,FACCU+7
  LD HL,ARG+7
  LD B,$07
DECDIV_2:
  LD A,(HL)
  OR A
  JP NZ,DECDIV_3
  DEC DE
  DEC HL
  DEC B
  JP NZ,DECDIV_2
DECDIV_3:
  LD (DECTM2),HL
  EX DE,HL
  LD (DECTMP),HL
  LD A,B
  LD (DECCNT),A
  LD HL,HOLD
DECDIV_4:
  LD B,$0F
DECDIV_5:
  PUSH HL
  PUSH BC
  LD HL,(DECTM2)
  EX DE,HL
  LD HL,(DECTMP)
  LD A,(DECCNT)
  LD C,$FF
DECDIV_6:
  SCF
  INC C
  LD B,A
  PUSH HL
  PUSH DE
DECDIV_7:
  LD A,$99
  ADC A,$00
  EX DE,HL
  SUB (HL)
  EX DE,HL
  ADD A,(HL)
  DAA
  LD (HL),A
  DEC HL
  DEC DE
  DEC B
  JP NZ,DECDIV_7
  LD A,(HL)
  CCF
  SBC A,$00
  LD (HL),A
  POP DE
  POP HL
  LD A,(DECCNT)
  JP NC,DECDIV_6
  LD B,A
  EX DE,HL
  CALL DAA_PASS2
  JP NC,DECDIV_8
  EX DE,HL
  INC (HL)
DECDIV_8:
  LD A,C
  POP BC
  LD C,A
  PUSH BC
  LD A,B
  OR A
  RRA
  LD B,A
  INC B
  LD E,B
  LD D,$00
  LD HL,FACCU-1
  ADD HL,DE
  CALL BCDADD_5
  POP BC
  POP HL
  LD A,B
  INC C
  DEC C
  JP NZ,DECDIV_13
  CP $0F
  JP Z,DECDIV_12
  RRCA
  RLCA
  JP NC,DECDIV_13
  PUSH BC
  PUSH HL
  LD HL,FACCU
  LD B,$08
DECDIV_9:
  LD A,(HL)
  OR A
  JP NZ,DECDIV_11
  INC HL
  DEC B
  JP NZ,DECDIV_9
  POP HL
  POP BC
  LD A,B
  OR A
  RRA
  INC A
  LD B,A
  XOR A
DECDIV_10:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,DECDIV_10
  JP DECDIV_16

DECDIV_11:
  POP HL
  POP BC
  LD A,B
  JP DECDIV_13
DECDIV_12:
  LD A,(FACCU-1)
  LD E,A
  DEC A
  LD (FACCU-1),A
  XOR E
  JP P,DECDIV_4
  JP ZERO_EXPONENT

DECDIV_13:
  RRA
  LD A,C
  JP C,DECDIV_14
  OR (HL)
  LD (HL),A
  INC HL
  JP DECDIV_15

DECDIV_14:
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD (HL),A
DECDIV_15:
  DEC B
  JP NZ,DECDIV_5
DECDIV_16:
  LD HL,FACCU+8
  LD DE,HOLD+7
  LD B,$08
  CALL LDDR_DEHL
  JP NORMALIZE

; This entry point is used by the routine at DECADD.
LDIR_C_BYTES:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC C
  JP NZ,LDIR_C_BYTES
  RET

; Move (HL) to (DE), C times.
;
; Used by the routines at BCDADD and DECMUL.
LDIR_C:
  LD A,(HL)
  LD (DE),A
  DEC HL
  DEC DE
  DEC C
  JP NZ,LDIR_C
  RET

; COS
;
; Used by the routine at __TAN.
__COS:
  LD HL,FP_EPSILON
  CALL MULPHL
  LD A,(FACCU)
  AND $7F
  LD (FACCU),A
  LD HL,FP_QUARTER
  CALL SUBPHL
  CALL INVSGN_0
  JP __SIN_0

; Routine at 12041
;
; Used by the routine at __TAN.
__SIN:
  LD HL,FP_EPSILON
  CALL MULPHL
; This entry point is used by the routine at __COS.
__SIN_0:
  LD A,(FACCU)
  OR A
  CALL M,NEGAFT
  CALL STAKFP
  CALL __INT
  CALL FAC1_ARG
  CALL USTAKFP
  CALL DECSUB
  LD A,(FACCU)
  CP $40
  JP C,__SIN_2
  LD A,(FACCU+1)
  CP $25
  JP C,__SIN_2
  CP $75
  JP NC,__SIN_1
  CALL FAC1_ARG
  LD HL,FP_HALF
  CALL HL2FACCU
  CALL DECSUB
  JP __SIN_2
__SIN_1:
  LD HL,FP_UNITY
  CALL HL2ARG
  CALL DECSUB
__SIN_2:
  LD HL,FP_SINTAB
  JP SUMSER

; Routine at 12120
__TAN:
  CALL STAKFP
  CALL __COS
  CALL XSTKFP
  CALL __SIN
  CALL USTAKARG
  LD A,(ARG)
  OR A
  JP NZ,DECDIV
  JP OV_ERR

; ATN
__ATN:
  LD A,(FACCU)
  OR A
  RET Z
  CALL M,NEGAFT
  CP $41			; Number less than 1?
  JP C,__ATN_0		; Yes - Get arc tangnt
  CALL FAC1_ARG
  LD HL,FP_UNITY
  CALL HL2FACCU
  CALL DECDIV
  CALL __ATN_0
  CALL FAC1_ARG
  LD HL,FP_HALFPI
  CALL HL2FACCU
  JP DECSUB

__ATN_0:
  LD HL,FP_TAN15
  CALL CMPPHL
  JP M,__ATN_1
  CALL STAKFP
  LD HL,FP_SQR3
  CALL ADDPHL
  CALL XSTKFP
  LD HL,FP_SQR3
  CALL MULPHL
  LD HL,FP_UNITY
  CALL SUBPHL
  CALL USTAKARG
  CALL DECDIV
  CALL __ATN_1
  LD HL,FP_SIXTHPI
  JP ADDPHL
__ATN_1:
  LD HL,FP_ATNTAB
  JP SUMSER

; LOG
;
; Used by the routine at DECEXP.
__LOG:
  RST TSTSGN
  JP M,FC_ERR
  JP Z,FC_ERR
  LD HL,FACCU
  LD A,(HL)
  PUSH AF
  LD (HL),$41
  LD HL,FP_10EXHALF
  CALL CMPPHL
  JP M,__LOG_0
  POP AF
  INC A
  PUSH AF
  LD HL,FACCU
  DEC (HL)
__LOG_0:
  POP AF
  LD (TEMP3),A
  CALL STAKFP
  LD HL,FP_UNITY
  CALL ADDPHL
  CALL XSTKFP
  LD HL,FP_UNITY
  CALL SUBPHL
  CALL USTAKARG
  CALL DECDIV
  CALL STAKFP
  CALL SQUAREFP
  CALL STAKFP
  CALL STAKFP
  LD HL,FP_LOGTAB2		; 5 values series
  CALL SMSER1
  CALL XSTKFP
  LD HL,FP_LOGTAB		; 4 values series
  CALL SMSER1
  CALL USTAKARG
  CALL DECDIV
  CALL USTAKARG
  CALL DECMUL
  LD HL,FP_TWODLN10
  CALL ADDPHL
  CALL USTAKARG
  CALL DECMUL
  CALL STAKFP
  LD A,(TEMP3)
  SUB $41
  LD L,A
  ADD A,A
  SBC A,A
  LD H,A
  CALL HL_CSNG
  CALL ZERO_FACCU
  CALL USTAKARG
  CALL DECADD
  LD HL,FP_LN10
  JP MULPHL

; SQR
__SQR:
  RST TSTSGN
  RET Z
  JP M,FC_ERR
  CALL FAC1_ARG
  LD A,(FACCU)
  OR A
  RRA
  ADC A,$20
  LD (ARG),A
  LD A,(FACCU+1)
  OR A
  RRCA
  OR A
  RRCA
  AND $33
  ADD A,$10
  LD (ARG+1),A
  LD A,$07
__SQR_0:
  LD (TEMP3),A
  CALL STAKFP
  CALL STAKARG
  CALL DECDIV
  CALL USTAKARG
  CALL DECADD
  LD HL,FP_HALF
  CALL MULPHL
  CALL FAC1_ARG
  CALL USTAKFP
  LD A,(TEMP3)
  DEC A
  JP NZ,__SQR_0
  JP ARG_FAC1

; Routine at 12452
;
; Used by the routine at DECEXP.
__EXP:
  LD HL,FP_LOG10E
  CALL MULPHL
  CALL STAKFP
  CALL __CINT
  LD A,L
  RLA
  SBC A,A
  CP H
  JP Z,__EXP_1
  LD A,H
  OR A
  JP P,__EXP_0
  CALL __CDBL_1
  CALL USTAKFP
  LD HL,FP_ZERO
  JP HL2FACCU
__EXP_0:
  JP OV_ERR
__EXP_1:
  LD (TEMP3),HL
  CALL __CDBL
  CALL FAC1_ARG
  CALL USTAKFP
  CALL DECSUB
  LD HL,FP_HALF
  CALL CMPPHL
  PUSH AF
  JP Z,__EXP_2
  JP C,__EXP_2
  LD HL,FP_HALF
  CALL SUBPHL
__EXP_2:
  CALL STAKFP
  LD HL,FP_EXPTAB2
  CALL SUMSER
  CALL XSTKFP
  LD HL,FP_EXPTAB1
  CALL NEGAFT_0
  CALL USTAKARG
  CALL STAKARG
  CALL STAKFP
  CALL DECSUB
  LD HL,HOLD
  CALL DBL_FACCU2HL
  CALL USTAKARG
  CALL USTAKFP
  CALL DECADD
  LD HL,HOLD
  CALL HL2ARG
  CALL DECDIV
  POP AF
  JP C,__EXP_3
  JP Z,__EXP_3
  LD HL,FP_10EXHALF
  CALL MULPHL
__EXP_3:
  LD A,(TEMP3)
  LD HL,FACCU
  LD C,(HL)
  ADD A,(HL)
  LD (HL),A
  XOR C
  RET P
  JP OV_ERR

; Routine at 12606
__RND:
  RST TSTSGN
  LD HL,RNDX
  JP Z,__RND_0
  CALL M,DBL_FACCU2HL
  LD HL,HOLD
  LD DE,RNDX
  CALL DBL2HL
  LD HL,RNDDOSPC
  CALL HL2ARG
  LD HL,RNDASPCS
  CALL HL2FACCU
  LD DE,HOLD+7
  CALL DECMUL_2
  LD DE,FACCU+8
  LD HL,SEEDRD
  LD B,$07
  CALL REV_LDIR_B
  LD HL,RNDX
  LD (HL),$00
__RND_0:
  CALL HL2FACCU
  LD HL,FACCU
  LD (HL),$40
  XOR A
  LD (FACCU+8),A
  JP DECNRM		; Single precision normalization
  
; This entry point is used by the routine at _CLREG.
INIT_RND:
  LD DE,RNDX_INIT
  LD HL,RNDX
  JP DBL2HL

; ..how is this called ?
GET_RNDX:
  CALL HL_CSNG
  LD HL,RNDX
  JP DBL_FACCU2HL

; This entry point is used by the routines at __ATN and __LOG.
ADDPHL:
  CALL HL2ARG
  JP DECADD
  
; This entry point is used by the routines at __COS, __ATN, __LOG and __EXP.
SUBPHL:
  CALL HL2ARG
  JP DECSUB

; Double precision square of FAC1 (FAC1=FAC1 squared)
;
; Used by the routines at __LOG and NEGAFT.
; a.k.a. DBL_SQUARE
SQUAREFP:
  LD HL,FACCU

; ADD number at HL to BCDE
;
; Used by the routines at __COS, __SIN, __ATN, __LOG, __SQR, __EXP, NEGAFT and INTEXP.
; a.k.a. DBL_SQUARE
MULPHL:
  CALL HL2ARG
  JP DECMUL
  
DIVPHL:
  CALL HL2ARG
  JP DECDIV

; This entry point is used by the routines at __ATN, __LOG and __EXP.
CMPPHL:
  CALL HL2ARG
  JP XDCOMP

; Move FAC1 to ARG
;
; Used by the routines at __SIN, __ATN, __SQR, __EXP, INTEXP and NULSUB.
; a.k.a. FACCU2ARG
IF KC85 | M10
FACCU2ARG:
ENDIF
FAC1_ARG:
  LD HL,FACCU

; Move the floating point buffer in (HL) to ARG.
;
; Used by the routines at __SIN, __EXP, __RND, MULPHL and NEGAFT.
HL2ARG:
  LD DE,ARG
; This entry point is used by the routine at HL2FACCU.
HL2ARG_0:
  EX DE,HL
  CALL DBL2HL
  EX DE,HL
  RET

; Move ARG to FAC1
;
; Used by the routines at __SQR, DBL_FACCU2HL, DECEXP and INTEXP.
ARG_FAC1:
  LD HL,ARG

; Move (HL) to FAC1
;
; Used by the routines at __SIN, __ATN, __EXP, __RND, NEGAFT, PUFOUT, DECEXP
; and INTEXP.
HL2FACCU:
  LD DE,FACCU
  JP HL2ARG_0

; Move FAC1 to (HL)
;
; Used by the routines at __EXP, __RND, NEGAFT, DECEXP and INTEXP.
DBL_FACCU2HL:
  LD DE,FACCU
; This entry point is used by the routines at __RND and HL2ARG.
DBL2HL:
  LD B,$08
  JP REV_LDIR_B

; This entry point is used by the routines at __TAN, __ATN, __LOG, __EXP, FEXP
; and DECEXP.
; Exchange stack and FP value (ARG is used and left = FACCU)
XSTKFP:
  POP HL
  LD (FBUFFR),HL
  CALL USTAKARG
  CALL STAKFP
  CALL ARG_FAC1
  LD HL,(FBUFFR)
  JP (HL)

; Negate number
;
; Used by the routines at __SIN and __ATN.
NEGAFT:
  CALL INVSGN_0
  LD HL,INVSGN_0
  EX (SP),HL
  JP (HL)

; This entry point is used by the routine at __EXP.
NEGAFT_0:
  LD (FBUFFR),HL
  CALL SQUAREFP
  LD HL,(FBUFFR)
  JP SMSER1

; This entry point is used by the routines at __SIN, __ATN and __EXP.
; Routine at 12791
SUMSER:
  LD (FBUFFR),HL
; Routine at 12792
  CALL STAKFP
  LD HL,(FBUFFR)
  CALL NEGAFT_0
  CALL USTAKARG
  JP DECMUL
  
; This entry point is used by the routine at __LOG.
SMSER1:
  LD A,(HL)
  PUSH AF
  INC HL
  PUSH HL
  LD HL,FBUFFR          ; Buffer for fout
  CALL DBL_FACCU2HL
  POP HL
  CALL HL2FACCU
SUMLP:
  POP AF
  DEC A
  RET Z
  PUSH AF
  PUSH HL
  LD HL,FBUFFR
  CALL MULPHL
  POP HL
  CALL HL2ARG
  PUSH HL
  CALL DECADD
  POP HL
  JP SUMLP

; Push FAC1 on stack
;
; Used by the routines at __SQR, __EXP, FEXP and INTEXP.
STAKARG:
  LD HL,ARG+7
  JP STAKFP_0

; Push ARG on stack
;
; Used by the routines at __SIN, __TAN, __ATN, __LOG, __SQR, __EXP, DBL_FACCU2HL,
; NEGAFT, DECEXP and INTEXP.
STAKFP:
  LD HL,FACCU+7
; This entry point is used by the routine at STAKARG.
STAKFP_0:
  LD A,$04
  POP DE
STAKFP_1:
  LD B,(HL)
  DEC HL
  LD C,(HL)
  DEC HL
  PUSH BC
  DEC A
  JP NZ,STAKFP_1
  EX DE,HL
  JP (HL)

; Pop ARG off stack
;
; Used by the routines at __TAN, __ATN, __LOG, __SQR, __EXP, DBL_FACCU2HL, NEGAFT,
; FEXP, DECEXP and INTEXP.
USTAKARG:
  LD HL,ARG
  JP USTAK_SUB

; Pop FAC1 off stack
;
; Used by the routines at __SIN, __SQR, __EXP and INTEXP.
USTAKFP:
  LD HL,FACCU
; This entry point is used by the routine at USTAKARG.
USTAK_SUB:
  LD A,$04
  POP DE
USTAK_SUB_0:
  POP BC
  LD (HL),C
  INC HL
  LD (HL),B
  INC HL
  DEC A
  JP NZ,USTAK_SUB_0
  EX DE,HL
  JP (HL)


; $325C

; FP "operands" for RND

RNDASPCS:
  DEFB $00,$14,$38,$98,$20,$42,$08,$21

RNDDOSPC:
  DEFB $00,$21,$13,$24,$86,$54,$05,$19 

; Constant to initialize the "last random number" variable
RNDX_INIT:
  DEFB $00,$40,$64,$96,$51,$37,$23,$58


; FP Numeric constants

FP_LOG10E:
  DEFB $40,$43,$42,$94,$48,$19,$03,$24		; LOG(E)	 =~  0.43429448190324

FP_HALF:
  DEFB $40,$50								; 0.5
FP_ZERO:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00		; 0

; Why did they optimize space for FP_HALF and
; preferred not to reuse the last value of FP_ATNTAB for FP UNITY ?
FP_UNITY:
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		;  1

FP_QUARTER:
  DEFB $40,$25,$00,$00,$00,$00,$00,$00		; 1/4		=  0.25

FP_10EXHALF:
  DEFB $41,$31,$62,$27,$76,$60,$16,$84		; 10^(1/2)  =~ 3.1622776601684

FP_TWODLN10:
  DEFB $40,$86,$85,$88,$96,$38,$06,$50		; 2/LN(10)	=~ 0.8685889638065

FP_LN10:
  DEFB $41,$23,$02,$58,$50,$92,$99,$40		; LN(10)	=~ 2.302585092994

FP_HALFPI:
  DEFB $41,$15,$70,$79,$63,$26,$79,$49		; PI/2		=~ 1.5707963267949 

FP_TAN15:
  DEFB $40,$26,$79,$49,$19,$24,$31,$12		; TAN(15)	=~ 0.26794919243112

FP_SQR3:
  DEFB $41,$17,$32,$05,$08,$07,$56,$89		; SQR(3)	=~ 1.7320508075689

FP_SIXTHPI:
  DEFB $40,$52,$35,$98,$77,$55,$98,$30		; PI/6		=~ 0.5235987755983

FP_EPSILON:
  DEFB $40,$15,$91,$54,$94,$30,$91,$90		; 1/(2*PI)	=~  0.1591549430919
  
FP_EXPTAB1:
  DEFB $04	; 4 values series
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		; 1
  DEFB $43,$15,$93,$74,$15,$23,$60,$31		; 159.37415236031
  DEFB $44,$27,$09,$31,$69,$40,$85,$16		; 2709.3169408516
  DEFB $44,$44,$97,$63,$35,$57,$40,$58		; 4497.6335574058

FP_EXPTAB2:
  DEFB $03	; 3 values
  DEFB $42,$18,$31,$23,$60,$15,$92,$75		; 18.31236015975
  DEFB $43,$83,$14,$06,$72,$12,$93,$71		; 831.4067219371
  DEFB $44,$51,$78,$09,$19,$91,$51,$62		; 5178.0919915162
  
FP_LOGTAB:
  DEFB $04	; 4 values
  DEFB $c0,$71,$43,$33,$82,$15,$32,$26		; -0.71433382153226
  DEFB $41,$62,$50,$36,$51,$12,$79,$08		; 6.2503651127908
  DEFB $C2,$13,$68,$23,$70,$24,$15,$03		; -13.682370241503
  DEFB $41,$85,$16,$73,$19,$87,$23,$89		; 8.5167319872389

FP_LOGTAB2:
  DEFB $05	; 5 values
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		; 1
  DEFB $C2,$13,$21,$04,$78,$35,$01,$56		; -13.210478350156
  DEFB $42,$47,$92,$52,$56,$04,$38,$73		; 47.925256043873
  DEFB $C2,$64,$90,$66,$82,$74,$09,$43		; -64.906682740943
  DEFB $42,$29,$41,$57,$50,$17,$23,$23		; 29.415750172323

; Compared to the earlier BASIC versions this one is much more accurate
; the first three values of the list were simply missing
FP_SINTAB:
  DEFB $08	; 8 values
  DEFB $C0,$69,$21,$56,$92,$29,$18,$09		; -0.69215692291809
  DEFB $41,$38,$17,$28,$86,$38,$57,$71 		; 3.8172886385771
  DEFB $C2,$15,$09,$44,$99,$47,$48,$01		; -15.094499474801
  DEFB $42,$42,$05,$86,$89,$66,$73,$55		; 42.048689667355
  DEFB $c2,$76,$70,$58,$59,$68,$32,$91		; -76.605859683291 
  DEFB $42,$81,$60,$52,$49,$27,$55,$13		; 81.605249275513
  DEFB $c2,$41,$34,$17,$02,$24,$03,$98		; -41.341702240398
  DEFB $41,$62,$83,$18,$53,$07,$17,$96		; 6.2831853071796

FP_ATNTAB:
  DEFB $08	; 8 values                      ; Approx. conversion of list
  DEFB $BF,$52,$08,$69,$39,$04,$00,$00		; -1/19.2    =~ -0.05208693904   
  DEFB $3F,$75,$30,$71,$49,$13,$48,$00		;  1/13.28   =~  0.0753071491348
  DEFB $bf,$90,$81,$34,$32,$24,$70,$50		; -1/11   =~ -0.09081343224705
  DEFB $40,$11,$11,$07,$94,$18,$40,$29		;  1/9    =~  0.11110794184029
IF KC85
; MSX style ATN table
  DEFB $C0,$14,$28,$57,$08,$55,$48,$84		; -1/7    =~ -0.14285708554884
ELSE
; TRS80 M100 style ATN table
  DEFB $C0,$14,$28,$56,$08,$55,$48,$84		; -1/7    =~ -0.14285608554884
ENDIF
  DEFB $40,$19,$99,$99,$99,$94,$89,$67		;  1/5    =~  0.19999999948967
  DEFB $C0,$33,$33,$33,$33,$33,$31,$60		; -1/3    =~ -0,3333333333316
  DEFB $41,$10,$00,$00,$00,$00,$00,$00		;  1/1    =  1



; Test sign of FPREG
;
; Used by the routines at TSTSGN, __TSTSGN, FCOMP and ICOMP.
_TSTSGN:
  LD A,(FACCU)
  OR A
  RET Z
  LD A,(FACCU)
  JP SGN_RESULT
  
; This entry point is used by the routine at DECCOMP.
_TSTSGN_0:
  CPL
; This entry point is used by the routines at __TSTSGN and ICOMP.
SGN_RESULT:
  RLA
; This entry point is used by the routines at CAS_OPNI_CO and ICOMP.
SIGNS:
  SBC A,A
  RET NZ
; This entry point is used by the routine at FP_SINTAB.
  INC A
  RET
  
; This entry point is used by the routines at DECADD, DECMUL, DECDIV and
; __INT.
ZERO_EXPONENT:
  XOR A
  LD (FACCU),A
  RET

__ABS:
  CALL __TSTSGN
  RET P

; Invert number sign
;
; Used by the routines at NVRFIL, __FIX, _ASCTFP and PUFOUT.
INVSGN:
  RST GETYPR
  JP M,DBL_ABS
  JP Z,TM_ERR
; This entry point is used by the routines at __COS, NEGAFT, HL_CSNG, __FIX,
; IMULT and FSUB.
INVSGN_0:
  LD HL,FACCU
  LD A,(HL)
  OR A
  RET Z
  XOR $80
  LD (HL),A
  RET

; Routine at 13319
__SGN:
  CALL __TSTSGN

; Get back from function, result in A (signed)
;
; Used by the routines at DCXH, __EOF and CSRLIN.
INT_RESULT_A:
  LD L,A
  RLA
  SBC A,A
  LD H,A
  JP MAKINT

; Test sign in number
;
; Used by the routines at __IF, __ABS, __SGN and PUFOUT.
__TSTSGN:
  RST GETYPR
  JP Z,TM_ERR
  JP P,_TSTSGN
  LD HL,(FACLOW)
; This entry point is used by the routine at STEP.
__TSTSGN_0:
  LD A,H
  OR L
  RET Z
  LD A,H
  JP SGN_RESULT

; Put FP value on stack
;
; Used by the routines at EVAL3, IDIV, IADD and IMULT.
STAKI:
  EX DE,HL
  LD HL,(FACLOW)
  EX (SP),HL
  PUSH HL
  LD HL,(FACCU)
  EX (SP),HL
  PUSH HL
  EX DE,HL
  RET

; Number at HL to BCDE
PHLTFP:
  CALL LOADFP

; Move BCDE to FPREG
;
; Used by the routine at EVAL3.
FPBCDE:
  EX DE,HL
  LD (FACLOW),HL
  LD H,B
  LD L,C
  LD (FACCU),HL
  EX DE,HL
  RET

; Load the single precision value in FAC1 into BCDE
;
; Used by the routines at STEP and EVAL3.
BCDEFP:
  LD HL,(FACLOW)
  EX DE,HL
; This entry point is used by the routine at FP_SINTAB.
BCDEFP_0:
  LD HL,(FACCU)
  LD C,L
  LD B,H
  RET

; Load 4 byte single precision buffer in HL into BCDE
;
; Used by the routine at __NEXT.
; a.k.a. LOADFP_CBED
HLBCDE:
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  RET

; Load FP value pointed by HL to BCDE
;
; Used by the routines at TESTR, PHLTFP, DBL_ABS and __NEXT.
LOADFP:
  LD E,(HL)
  INC HL
; This entry point is used by the routine at PRS1.
LOADFP_0:
  LD D,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
; This entry point is used by the routines at PROMPT, PUFOUT, TEL_TERM and
; BOOT.
INCHL:
  INC HL
  RET

; Move the single precision number in FAC1 to (HL)
;
; Used by the routine at __NEXT.
FAC1_HL:
  LD DE,FACCU
  LD B,$04
  JP REV_LDIR_B

; Move the buffer pointed to by HL to ARG
;
; Used by the routines at DECSUB and __NEXT.
HL_ARG:
  LD DE,ARG
  
; Copy number value from HL to DE
VAL2DE:
  EX DE,HL

; This entry point is used by the routines at STEP, __LET, TSTOPL and INSTR.
; Copy number value from DE to HL
FP2HL:
  LD A,(VALTYP)
  LD B,A

; Move the memory from (DE) to (HL) for B bytes
;
; Used by the routines at __IPL, ON_TIME_S, MAKTXT, __RND, DBL_FACCU2HL, FAC1_HL and
; BOOT.
REV_LDIR_B:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DEC B
  JP NZ,REV_LDIR_B
  RET

; Move the memory from (DE) to (HL) for B bytes, pointers are decremented
;
; Used by the routines at DECMUL and DECDIV.
LDDR_DEHL:
  LD A,(DE)
  LD (HL),A
  DEC DE
  DEC HL
  DEC B
  JP NZ,LDDR_DEHL
  RET
  
; This entry point is used by the routine at DECADD.
FP_ARG2DE:
  LD HL,ARG

; This entry point is used by the routines at EVAL_VARIABLE and __NEXT.
FP_HL2DE:
  LD DE,VAL2DE 		; Copy number value from HL to DE
  JP FPCOPY_0

; This entry point is used by the routine at EVAL3.
FP_ARG2HL:
  LD HL,ARG

; This entry point is used by the routines at STEP and __NEXT.
FP_DE2HL:
  LD DE,FP2HL		; Copy number value from DE to HL

FPCOPY_0:
  PUSH DE
  LD DE,FACCU
  LD A,(VALTYP)
  CP $02
  RET NZ
  LD DE,FACLOW
  RET

; Compare the single precision number in BCDE with FAC1.
;
; Used by the routines at GETWORD, MAKINT and __NEXT.
; Formerly known as "CMPNUM", a.k.a. BCDE_FP_CMP
FCOMP:
  LD A,C
  OR A
  JP Z,_TSTSGN
  LD HL,_TSTSGN_0
  PUSH HL
  RST TSTSGN
  LD A,C
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  CALL CMPFP
  RRA
  XOR C
  RET

; Used by the routine at FCOMP.
CMPFP:
  LD A,C
  CP (HL)
  RET NZ
  INC HL
  LD A,B
  CP (HL)
  RET NZ
  INC HL
  LD A,E
  CP (HL)
  RET NZ
  INC HL
  LD A,D
  SUB (HL)
  RET NZ
  POP HL
  POP HL
  RET

; Compare the signed integer in DE to the signed integer in HL
;
; Used by the routine at __NEXT.
; a.k.a. CMP_HLDE
ICOMP:
  LD A,D
  XOR H
  LD A,H
  JP M,SGN_RESULT
  CP D
  JP NZ,ICOMP_0
  LD A,L
  SUB E
  RET Z
ICOMP_0:
  JP SIGNS

; This entry point is used by the routines at MULPHL, DECCOMP, INTEXP and
; __NEXT.
XDCOMP:
  LD DE,ARG
  LD A,(DE)
  OR A
  JP Z,_TSTSGN
  LD HL,_TSTSGN_0
  PUSH HL
  RST TSTSGN
  LD A,(DE)
  LD C,A
  RET Z
  LD HL,FACCU
  XOR (HL)
  LD A,C
  RET M
  LD B,$08
XDCOMP_2:
  LD A,(DE)
  SUB (HL)
  JP NZ,XDCOMP_1
  INC DE
  INC HL
  DEC B
  JP NZ,XDCOMP_2
  POP BC
  RET

XDCOMP_1:
  RRA
  XOR C
  RET

; Compare the double precision numbers in FAC1 and ARG
DECCOMP:
  CALL XDCOMP
  JP NZ,_TSTSGN_0
  RET

; Routine at 13569
;
; Used by the routines at TO, EVAL3, NOT, _GETYPR, DEPINT and __EXP.
__CINT:
  RST GETYPR
  LD HL,(FACLOW)
  RET M
  JP Z,TM_ERR		; If string type, "Type mismatch"
  CALL CINT
  JP C,OV_ERR
  EX DE,HL

; Load the signed integer in HL into FAC1
;
; Used by the routines at NVRFIL, PASSA, INT_RESULT_A, __INT, IMULT,
; INT_DIV, FIN_DBL, NUMPRT and INTEXP.
MAKINT:
  LD (FACLOW),HL

; This entry point is used by the routine at DBL_ABS.
SETTYPE_INT:
  LD A,$02

; This entry point is used by the routine at __CDBL.
SETTYPE:
  LD (VALTYP),A
  RET
  
; This entry point is used by the routine at _ASCTFP.
MAKINT_2:
  LD BC,$32C5		; BCDE = -32768 (float)
  LD DE,$8076
  CALL FCOMP
  RET NZ
  LD HL,$8000		; HL = 32768
; This entry point is used by the routine at IADD.
MAKINT_2_0:
  POP DE
  JP MAKINT

; Convert the number in FAC1 to single precision.
;
; Used by the routines at STEP, EVAL3, GETWORD and _ASCTFP.
__CSNG:
  RST GETYPR
  RET PO
  JP M,INT_CSNG
  JP Z,TM_ERR
  CALL __CDBL_2
  CALL L3D04
  INC HL
  LD A,B
  OR A
  RRA
  LD B,A
  JP BNORM_8

; Convert the signed integer in FAC1 to single precision.
;
; Used by the routines at __CSNG, __CDBL, _ASCTFP and PUFOUT.
INT_CSNG:
  LD HL,(FACLOW)

; Convert the signed integer in HL to a single precision number
;
; Used by the routines at EVAL3, IDIV, __LOG, __RND, IADD, IMULT and
; INTEXP.
HL_CSNG:
  LD A,H
; This entry point is used by the routine at DBL_ABS.
HL_CSNG_0:
  OR A
  PUSH AF
  CALL M,INT_DIV_6
  CALL __CDBL_2
  EX DE,HL
  LD HL,$0000
  LD (FACCU),HL
  LD (FACLOW),HL
  LD A,D
  OR E
  JP Z,POPAF
  LD BC,$0500
  LD HL,FACCU+1
  PUSH HL
  LD HL,HL_CSNG_8
HL_CSNG_1:
  LD A,$FF
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  PUSH BC
HL_CSNG_2:
  LD B,H
  LD C,L
  ADD HL,DE
  INC A
  JP C,HL_CSNG_2
  LD H,B
  LD L,C
  POP BC
  POP DE
  EX DE,HL
  INC C
  DEC C
  JP NZ,HL_CSNG_3
  OR A
  JP Z,HL_CSNG_6
  PUSH AF
  LD A,$40
  ADD A,B
  LD (FACCU),A
  POP AF
HL_CSNG_3:
  INC C
  EX (SP),HL
  PUSH AF
  LD A,C
  RRA
  JP NC,HL_CSNG_4
  POP AF
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD (HL),A
  JP HL_CSNG_5

HL_CSNG_4:
  POP AF
  OR (HL)
  LD (HL),A
  INC HL
HL_CSNG_5:
  EX (SP),HL
HL_CSNG_6:
  LD A,D
  OR E
  JP Z,HL_CSNG_7
  DEC B
  JP NZ,HL_CSNG_1
HL_CSNG_7:
  POP HL
  POP AF
  RET P
  JP INVSGN_0
  
HL_CSNG_8:
  RET P
  RET C
  JR HL_CSNG_8
  SBC A,H
  RST $38
  OR $FF
  RST $38
  RST $38

; Routine at 13754
;
; Used by the routines at STEP, EVAL3, UCASE, __EXP, _ASCTFP, PUFOUT and
; NULSUB.
__CDBL:
  RST GETYPR
  RET NC
  JP Z,TM_ERR
  CALL M,INT_CSNG
; This entry point is used by the routines at __LOG, FLOAT_ADD, FMULT, FDIV,
; FEXP and INTEXP.
ZERO_FACCU:
  LD HL,$0000
  LD (FACCU+4),HL
  LD (FACCU+6),HL
  LD A,H
  LD (FACCU+8),A
; This entry point is used by the routines at __EXP and DECEXP.
__CDBL_1:
  LD A,$08
  JP __CDBL_3
; This entry point is used by the routines at __CSNG and HL_CSNG.
__CDBL_2:
  LD A,$04
__CDBL_3:
  JP SETTYPE

; Test a string, 'Type Error' if it is not
;
; Used by the routines at __LINE, UCASE, CONCAT, GETSTR, INSTR, USING and
; L4F2E.
TSTSTR:
  RST GETYPR
  RET Z
  JP TM_ERR				; If not string type, Err $0D - "Type mismatch"
  
; This entry point is used by the routines at __CINT and INTEXP.
CINT:
  LD HL,CINT_RET2
  PUSH HL
  LD HL,FACCU
  LD A,(HL)
  AND $7F
  CP $46
  RET NC
  SUB $41
  JP NC,CINT_SUB
  OR A
  POP DE
  LD DE,$0000
  RET

CINT_SUB:
  INC A
  LD B,A
  LD DE,$0000
  LD C,D
  INC HL
CINT_SUB_0:
  LD A,C
  INC C
  RRA
  LD A,(HL)
  JP C,CINT_SUB_1
  RRA
  RRA
  RRA
  RRA
  JP CINT_SUB_2

CINT_SUB_1:
  INC HL
CINT_SUB_2:
  AND $0F
  LD (DECTMP),HL
  LD H,D
  LD L,E
  ADD HL,HL
  RET C
  ADD HL,HL
  RET C
  ADD HL,DE
  RET C
  ADD HL,HL
  RET C
  LD E,A
  LD D,$00
  ADD HL,DE
  RET C
  EX DE,HL
  LD HL,(DECTMP)
  DEC B
  JP NZ,CINT_SUB_0
  LD HL,$8000
  RST CPDEHL
  LD A,(FACCU)
  RET C
  JP Z,CINT_RET1
  POP HL
  OR A
  RET P
  EX DE,HL
  CALL INT_DIV_6
  EX DE,HL
  OR A
  RET

CINT_RET1:
  OR A
  RET P
  POP HL
  RET

; Routine at 13889
CINT_RET2:
  SCF
  RET

; This entry point is used by the routine at LISPRT.
; Also used in the MSX, but probably useless on the KC85
DCXBRT:
  DEC BC
  RET

; Double Precision to Integer conversion
__FIX:
  RST GETYPR
  RET M
  RST TSTSGN
  JP P,__INT
  CALL INVSGN_0
  CALL __INT
  JP INVSGN

; Routine at 13908
;
; Used by the routines at __SIN, __FIX and INTEXP.
__INT:
  RST GETYPR
  RET M
  LD HL,FACCU+8
  LD C,$0E
  JP NC,__INT_0
  JP Z,TM_ERR
  LD HL,FACCU+4
  LD C,$06
__INT_0:
  LD A,(FACCU)
  OR A
  JP M,__INT_2
  AND $7F
  SUB $41
  JP C,ZERO_EXPONENT
  INC A
  SUB C
  RET NC
  CPL
  INC A
  LD B,A
__INT_1:
  DEC HL
  LD A,(HL)
  AND $F0
  LD (HL),A
  DEC B
  RET Z
  XOR A
  LD (HL),A
  DEC B
  JP NZ,__INT_1
  RET

__INT_2:
  AND $7F
  SUB $41
  JP NC,__INT_3
  LD HL,$FFFF
  JP MAKINT

__INT_3:
  INC A
  SUB C
  RET NC
  CPL
  INC A
  LD B,A
  LD E,$00
__INT_4:
  DEC HL
  LD A,(HL)
  LD D,A
  AND $F0
  LD (HL),A					; WR Secondary slot SETFIL register
  CP D
  JP Z,__INT_5
  INC E
__INT_5:
  DEC B
  JP Z,__INT_7
  XOR A
  LD (HL),A					; WR Secondary slot SETFIL register
  CP D
  JP Z,__INT_6
  INC E
__INT_6:
  DEC B
  JP NZ,__INT_4
__INT_7:
  INC E
  DEC E
  RET Z
  LD A,C
  CP $06			; TK_ABS ?
  LD BC,$10C1		; BCDE = 1 (float) 
  LD DE,$0000
  JP Z,FADD
  EX DE,HL
  LD (ARG+6),HL
  LD (ARG+4),HL
  LD (ARG_INT),HL		; = ARG+2
  LD H,B
  LD L,C
  LD (ARG),HL
  JP DECADD

; Multiply DE by BC
;
; Used by the routine at BS_ERR.
MLDEBC:
  PUSH HL
  LD HL,$0000      ; Clear partial product
  LD A,B           ; Test multiplier
  OR C             
  JP Z,MLDEBC_2    ; Return zero if zero
  LD A,$10         ; 16 bits
MLDEBC_0:          
  ADD HL,HL        ; Shift P.P left
  JP C,BS_ERR		; "Subscript error" if overflow
  EX DE,HL         
  ADD HL,HL        ; Shift multiplier left
  EX DE,HL         
  JP NC,MLDEBC_1   ; Bit was zero - No add
  ADD HL,BC        ; Add multiplicand
  JP C,BS_ERR		; "Subscript error" if overflow
MLDEBC_1:          
  DEC A            ; Count bits
  JP NZ,MLDEBC_0
MLDEBC_2:
  EX DE,HL
  POP HL
  RET

; Subtract the signed integer in HL from the signed integer in DE.
ISUB:
  LD A,H
  RLA
  SBC A,A
  LD B,A
  CALL INT_DIV_6
  LD A,C
  SBC A,B
  JP IADD_0

; Routine at 14084
;
; Used by the routine at __NEXT.
IADD:
  LD A,H
  RLA
  SBC A,A
; This entry point is used by the routine at ISUB.
IADD_0:
  LD B,A
  PUSH HL
  LD A,D
  RLA
  SBC A,A
  ADD HL,DE
  ADC A,B
  RRCA
  XOR H
  JP P,MAKINT_2_0
  PUSH BC
  EX DE,HL
  CALL HL_CSNG
  POP AF
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP FADD

; Integer MULTIPLY
;
; Used by the routine at INTEXP.
IMULT:
  LD A,H
  OR L
  JP Z,MAKINT
  PUSH HL
  PUSH DE
  CALL INT_DIV_3
  PUSH BC
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$10
IMULT_0:
  ADD HL,HL
  JP C,IMULT_4
  EX DE,HL
  ADD HL,HL
  EX DE,HL
  JP NC,IMULT_1
  ADD HL,BC
  JP C,IMULT_4
IMULT_1:
  DEC A
  JP NZ,IMULT_0
  POP BC
  POP DE
; This entry point is used by the routine at INT_DIV.
IMULT_RESULT:
  LD A,H
  OR A
  JP M,IMULT_3
  POP DE
  LD A,B
  JP INT_DIV_5

IMULT_3:
  XOR $80
  OR L
  JP Z,IMULT_6
  EX DE,HL
  JP IMULT_5

IMULT_4:
  POP BC
  POP HL
IMULT_5:
  CALL HL_CSNG
  POP HL
  CALL STAKI
  CALL HL_CSNG
  POP BC
  POP DE
  JP FMULT_BCDE

IMULT_6:
  LD A,B
  OR A
  POP BC
  JP M,MAKINT
  PUSH DE
  CALL HL_CSNG
  POP DE
  JP INVSGN_0

; Divide the signed integer in DE by the signed integer in HL.
;
; Used by the routines at _GETYPR and DBL_ABS.
INT_DIV:
  LD A,H
  OR L
  JP Z,O_ERR   		; "Division by zero"
  CALL INT_DIV_3
  PUSH BC
  EX DE,HL
  CALL INT_DIV_6
  LD B,H
  LD C,L
  LD HL,$0000
  LD A,$11		; const
  PUSH AF
  OR A
  JP INT_DIV_2

DIVLP:
  PUSH AF
  PUSH HL
  ADD HL,BC
  JP NC,INT_DIV_1
  POP AF
  SCF
  JP INT_DIV_2

INT_DIV_1:
  POP HL
INT_DIV_2:
  LD A,E			; Double LSB of quotient (LSW)
  RLA
  LD E,A
  LD A,D			; Double MSB of quotient (LSW)
  RLA
  LD D,A
  LD A,L			; Double LSB of quotient (MSW)
  RLA                 
  LD L,A              
  LD A,H			; Double MSB of quotient (MSW)              
  RLA
  LD H,A
  POP AF
  DEC A
  JP NZ,DIVLP
  EX DE,HL
  POP BC
  PUSH DE
  JP IMULT_RESULT

; This entry point is used by the routine at IMULT.
INT_DIV_3:
  LD A,H
  XOR D
  LD B,A
  CALL INT_DIV_4
  EX DE,HL
INT_DIV_4:
  LD A,H
; This entry point is used by the routines at IMULT and DBL_ABS.
INT_DIV_5:
  OR A
  JP P,MAKINT
; This entry point is used by the routines at HL_CSNG, TSTSTR, ISUB, DBL_ABS
; and INTEXP.
INT_DIV_6:
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
  JP MAKINT

; ABS (double precision BASIC variant)
;
; Used by the routine at INVSGN.
DBL_ABS:
  LD HL,(FACLOW)
  CALL INT_DIV_6
  LD A,H
  XOR $80
  OR L
  RET NZ
; This entry point is used by the routines at ERL, IMP, _MAXRAM and _HIMEM.
DBL_ABS_0:
  XOR A
  JP HL_CSNG_0
  
; This entry point is used by the routine at _GETYPR.
IMOD:
  PUSH DE
  CALL INT_DIV
  XOR A
  ADD A,D
  RRA
  LD H,A
  LD A,E
  RRA
  LD L,A
  CALL SETTYPE_INT
  POP AF
  JP INT_DIV_5

; (LOADFP/FADD.. this label is not used in the core ROM)
FADD_HLPTR:
  CALL LOADFP
; This entry point is used by the routines at GETWORD, __INT, IADD, FSUB and
; __NEXT.
FADD:
  CALL BCDEFP_ARG

; Add the single precision numbers in FAC1 and ARG
FLOAT_ADD:
  CALL ZERO_FACCU
  JP DECADD

; Subtract the single precision numbers in FAC1 and BCDE
FSUB:
  CALL INVSGN_0
  JP FADD

; Multiply the single precision numbers in FAC1 and BCDE
;
; Used by the routine at IMULT.
FMULT_BCDE:
  CALL BCDEFP_ARG

; Multiply the single precision numbers in FAC1 and ARG
FMULT:
  CALL ZERO_FACCU
  JP DECMUL

; This entry point is used by the routine at IDIV.
DIVIDE:
  POP BC
  POP DE

; Single precision divide (FAC1=BCDE/FAC1)
FDIV:
  LD HL,(FACLOW)
  EX DE,HL
  LD (FACLOW),HL
  PUSH BC
  LD HL,(FACCU)
  EX (SP),HL
  LD (FACCU),HL
  POP BC
  CALL BCDEFP_ARG
  CALL ZERO_FACCU
  JP DECDIV

; Load ARG with the single precision number in BCDE
;
; Used by the routines at DBL_ABS, FMULT_BCDE, FDIV and FEXP.
BCDEFP_ARG:
  EX DE,HL
  LD (ARG_INT),HL		; = ARG+2
  LD H,B
  LD L,C
  LD (ARG),HL
  LD HL,$0000
  LD (ARG+4),HL
  LD (ARG+6),HL
  RET

; This entry point is used by the routine at PUFOUT.
DCR_A:
  DEC A
  RET

; This entry point is used by the routine at PUFOUT.
DCXH_2:
  DEC HL
  RET

; This entry point is used by the routine at SCPTLP.
POPHLRT:
  POP HL
  RET

; ASCII to Double precision FP number
;
; Used by the routines at __READ, OPRND, __VAL and L4F2E.
FIN_DBL:
  EX DE,HL
  LD BC,$00FF
  LD H,B
  LD L,B
  CALL MAKINT		;  (HL_FAC1)
  EX DE,HL
  LD A,(HL)

; ASCII to FP number
_ASCTFP:
  CP '-'
  PUSH AF
  JP Z,_ASCTFP_0
  CP '+'
  JP Z,_ASCTFP_0
  DEC HL
_ASCTFP_0:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,_ASCTFP_DIGITS
  CP '.'
  JP Z,DPOINT
  CP 'e'
  JP Z,EXPONENTIAL
  CP 'E'
EXPONENTIAL:
  JP NZ,_ASCTFP_4
  PUSH HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP 'l'
  JP Z,_ASCTFP_2
  CP 'L'
  JP Z,_ASCTFP_2
  CP 'q'
  JP Z,_ASCTFP_2
  CP 'Q'
_ASCTFP_2:
  POP HL
  JP Z,_ASCTFP_3
  RST GETYPR
  JP NC,_ASCTFP_5
  XOR A
  JP _ASCTFP_6
_ASCTFP_3:
  LD A,(HL)
_ASCTFP_4:
  CP '%'
  JP Z,_ASCTFP_16
  CP '#'
  JP Z,_ASCTFP_17
  CP '!'
  JP Z,_ASCTFP_18
  CP 'd'
  JP Z,_ASCTFP_5
  CP 'D'
  JP NZ,_ASCTFP_10
_ASCTFP_5:
  OR A
_ASCTFP_6:
  CALL TO_DOUBLE
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH DE
  LD D,$00
  CALL SGNEXP
  LD C,D
  POP DE
_ASCTFP_7:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NC,_ASCTFP_9
  LD A,E
  CP $0C
  JP NC,_ASCTFP_8
  RLCA
  RLCA
  ADD A,E
  RLCA
  ADD A,(HL)
  SUB '0'
  LD E,A
  JP _ASCTFP_7

_ASCTFP_8:
  LD E,$80
  JP _ASCTFP_7
_ASCTFP_9:
  INC C
  JP NZ,_ASCTFP_10
  XOR A
  SUB E
  LD E,A
_ASCTFP_10:
  RST GETYPR
  JP M,_ASCTFP_11
  LD A,(FACCU)
  OR A
  JP Z,_ASCTFP_11
  LD A,D
  SUB B
  ADD A,E
  ADD A,$40
  LD (FACCU),A
  OR A
  CALL M,_ASCTFP_13
_ASCTFP_11:
  POP AF
  PUSH HL
  CALL Z,INVSGN
  RST GETYPR
  JP NC,_ASCTFP_12
  POP HL
  RET PE
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  CALL MAKINT_2
  RET

_ASCTFP_12:
  CALL DECROU
  POP HL
  RET

_ASCTFP_13:
  JP OV_ERR
DPOINT:
  RST GETYPR
  INC C
  JP NZ,_ASCTFP_10
  JP NC,_ASCTFP_15
  CALL TO_DOUBLE
  LD A,(FACCU)
  OR A
  JP NZ,_ASCTFP_15
  LD D,A
_ASCTFP_15:
  JP _ASCTFP_0
_ASCTFP_16:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  POP AF
  PUSH HL
  LD HL,POPHLRT
  PUSH HL
  LD HL,__CINT
  PUSH HL
  PUSH AF
  JP _ASCTFP_10
_ASCTFP_17:
  OR A
_ASCTFP_18:
  CALL TO_DOUBLE
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP _ASCTFP_10

TO_DOUBLE:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL Z,__CSNG
  POP AF
  CALL NZ,__CDBL
  POP BC
  POP DE
  POP HL
  RET

_ASCTFP_DIGITS:
  SUB '0'
  JP NZ,_ASCTFP_21
  OR C
  JP Z,_ASCTFP_21
  AND D
  JP Z,_ASCTFP_0
_ASCTFP_21:
  INC D
  LD A,D
  CP $07
  JP NZ,_ASCTFP_22
  OR A
  CALL TO_DOUBLE

_ASCTFP_22:
  PUSH DE
  LD A,B
  ADD A,C
  INC A
  LD B,A
  PUSH BC
  PUSH HL
  LD A,(HL)
  SUB '0'
  PUSH AF
  RST GETYPR
  JP P,_ASCTFP_26
  LD HL,(FACLOW)
  LD DE,$0CCD		; const
  RST CPDEHL
  JP NC,_ASCTFP_25
  LD D,H
  LD E,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  ADD HL,HL
  POP AF
  LD C,A
  ADD HL,BC
  LD A,H
  OR A
  JP M,_ASCTFP_24
  LD (FACLOW),HL
_ASCTFP_23:
  POP HL
  POP BC
  POP DE
  JP _ASCTFP_0

_ASCTFP_24:
  LD A,C
  PUSH AF
_ASCTFP_25:
  CALL INT_CSNG
_ASCTFP_26:
  POP AF
  POP HL
  POP BC
  POP DE
  JP NZ,_ASCTFP_27
  LD A,(FACCU)
  OR A
  LD A,$00
  JP NZ,_ASCTFP_27
  LD D,A
  JP _ASCTFP_0

_ASCTFP_27:
  PUSH DE
  PUSH BC
  PUSH HL
  PUSH AF
  LD HL,FACCU
  LD (HL),$01
  LD A,D
  CP $10
  JP C,_ASCTFP_28
  POP AF
  JP _ASCTFP_23


_ASCTFP_28:
  INC A
  OR A
  RRA
  LD B,$00                ;ADD [A] TO [H,L]
  LD C,A
  ADD HL,BC
  POP AF
  LD C,A
  LD A,D
  RRA
  LD A,C
  JP NC,_ASCTFP_29
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
_ASCTFP_29:
  OR (HL)
  LD (HL),A
  JP _ASCTFP_23

; 'in' <line number> message
;
; Used by the routine at ERESET.
LNUM_MSG:
  PUSH HL
  LD HL,IN_MSG
  CALL PRS
  POP HL

; Print HL in ASCII form at the current cursor position
;
; Used by the routines at __LIST, PRPARM and FREEMEM.
NUMPRT:
  LD BC,PRNUMS
  PUSH BC
  CALL MAKINT
  XOR A
  LD (TEMP3),A
  LD HL,NUMSTR
  LD (HL),' '
  OR (HL)
  JP SPCFST

; Convert the binary number in FAC1 to ASCII
;
; Used by the routines at __PRINT, __STR_S and PUFOUT.
FOUT:
  XOR A
; This entry point is used by the routine at USING.
; Convert number/expression to string (format specified in 'A' register)
FOUT_0:
  CALL NUMPRT_SUB

; Convert the binary number in FAC1 to ASCII.  A - Bit configuration for PRINT
; USING options
PUFOUT:
  AND $08
  JP Z,PUFOUT_0
  LD (HL),'+'
PUFOUT_0:
  EX DE,HL
  CALL __TSTSGN
  EX DE,HL
  JP P,SPCFST
  LD (HL),'-'
  PUSH BC
  PUSH HL
  CALL INVSGN
  POP HL
  POP BC
  OR H
; This entry point is used by the routine at NUMPRT.
SPCFST:
  INC HL
  LD (HL),'0'
  LD A,(TEMP3)
  LD D,A
  RLA
  LD A,(VALTYP)
  JP C,SPCFST5
  JP Z,SPCFST3
  CP $04			; single precision ?
  JP NC,PUFOUT_7
  LD BC,$0000
  CALL PUFOUT_55
PUFOUT_2:
  LD HL,NUMSTR
  LD B,(HL)
  LD C,' '
  LD A,(TEMP3)
  LD E,A
  AND $20			; bit 5 - Asterisks fill
  JP Z,PUFOUT_3
  LD A,B
  CP C
  LD C,'*'
  JP NZ,PUFOUT_3
  LD A,E
  AND $04			; bit 2 - Sign (+ or -) follows ASCII number  
  JP NZ,PUFOUT_3
  LD B,C
PUFOUT_3:
  LD (HL),C
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,PUFOUT_4
  CP 'E'
  JP Z,PUFOUT_4
  CP 'D'
  JP Z,PUFOUT_4
  CP '0'
  JP Z,PUFOUT_3
  CP ','
  JP Z,PUFOUT_3
  CP '.'
  JP NZ,PUFOUT_5
PUFOUT_4:
  DEC HL
  LD (HL),'0'
PUFOUT_5:
  LD A,E
  AND $10		; bit 4 - Print leading '$'  
  JP Z,PUFOUT_6
  DEC HL
  LD (HL),'$'
PUFOUT_6:
  LD A,E
  AND $04		; bit 2 - Sign (+ or -) follows ASCII number  
  RET NZ
  DEC HL
  LD (HL),B
  RET

PUFOUT_7:
  PUSH HL
  CALL L3D04
  LD D,B
  INC D
  LD BC,$0300			; const
  LD A,(FACCU)
  SUB $3F
  JP C,PUFOUT_8
  INC D
  CP D
  JP NC,PUFOUT_8
  INC A
  LD B,A
  LD A,$02
PUFOUT_8:
  SUB $02
  POP HL
  PUSH AF
  CALL PUFOUT_45
  LD (HL),'0'

PUFOUT_8B:
  CALL Z,INCHL
  CALL PUFOUT_51

SUPTLZ:
  DEC HL                ; Move back through buffer
  LD A,(HL)             ; Get character
  CP '0'                ; "0" character?
  JP Z,SUPTLZ           ; Yes - Look back for more
  CP '.'                ; A decimal point?
  CALL NZ,INCHL         ; Move back over digit
  POP AF                ; Get "E" flag
  JP Z,NOENED           ; No "E" needed - End buffer
  
DOEBIT:
  LD (HL),'E'           ; Put "E" in buffer
  INC HL                ; And move on
  LD (HL),'+'           ; Put '+' in buffer
  JP P,OUTEXP           ; Positive - Output exponent
  LD (HL),'-'           ; Put "-" in buffer
  CPL                   ; Negate exponent
  INC A
OUTEXP:
  LD B,'0'-1  ; $2F, '/'
EXPTEN:
  INC B
  SUB 10                ; ASCII "0" - 1
  JP NC,EXPTEN          
  ADD A,'0'+10          ; Count subtractions
  INC HL                ; Tens digit
  LD (HL),B             ; More to do
  INC HL                ; Restore and make ASCII
  LD (HL),A             ; Move on
SPCFST3:              ; Save MSB of exponent
  INC HL                
NOENED:                 ; Save LSB of exponent
  LD (HL),$00
  EX DE,HL
  LD HL,FBUFFR+1		; Buffer for fout + 1
  RET

SPCFST5:
  INC HL
  PUSH BC
  CP $04
  LD A,D
  JP NC,PUFOUT_24
  RRA
  JP C,PUFOUT_31
  LD BC,$0603			; const
  CALL PUFOUT_44
  POP DE
  LD A,D
  SUB $05
  CALL P,PUFOUT_37
  CALL PUFOUT_55
SPCFST6:
  LD A,E
  OR A
  CALL Z,DCXH_2
  DEC A
  CALL P,PUFOUT_37
SPCFST7:
  PUSH HL
  CALL PUFOUT_2
  POP HL
  JP Z,SPCFST8
  LD (HL),B
  INC HL
SPCFST8:
  LD (HL),$00
  LD HL,FBUFFR
SPCFST9:
  INC HL
PUFOUT_20:
  LD A,(NXTOPR)
  SUB L
  SUB D
  RET Z
  LD A,(HL)
  CP ' '
  JP Z,SPCFST9
  CP '*'
  JP Z,SPCFST9
  DEC HL
  PUSH HL

; Routine at 15122
L3B12:
  PUSH AF
  LD BC,L3B12
  PUSH BC
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP '-'
  RET Z
  CP '+'
  RET Z
  CP '$'
  RET Z
  POP BC
  CP '0'
  JP NZ,PUFOUT_23
  INC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NC,PUFOUT_23
  DEC HL
  JP PUFOUT_22
  
PUFOUT_21:
  DEC HL
  LD (HL),A
PUFOUT_22:
  POP AF
  JP Z,PUFOUT_21
  POP BC
  JP PUFOUT_20

PUFOUT_23:
  POP AF
  JP Z,PUFOUT_23
  POP HL
  LD (HL),'%'
  RET
  
PUFOUT_24:
  PUSH HL
  RRA
  JP C,PUFOUT_32
  CALL L3D04
  LD D,B
  LD A,(FACCU)
  SUB $4F
  JP C,PUFOUT_25
  POP HL
  POP BC
  CALL FOUT
  LD HL,FBUFFR
  LD (HL),'%'
  RET
  
PUFOUT_25:
  RST TSTSGN
  CALL NZ,PUFOUT_63
  POP HL
  POP BC
  JP M,PUFOUT_26
  PUSH BC
  LD E,A
  LD A,B
  SUB D
  SUB E
  CALL P,PUFOUT_37
  CALL PUFOUT_42
  CALL PUFOUT_51
  OR E
  CALL NZ,PUFOUT_41
  OR E
  CALL NZ,PUFOUT_47
  POP DE
  JP SPCFST6

PUFOUT_26:
  LD E,A
  LD A,C
  OR A
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,E
  JP M,PUFOUT_27
  XOR A
PUFOUT_27:
  PUSH BC
  PUSH AF
  CALL M,PUFOUT_60
  POP BC
  LD A,E
  SUB B
  POP BC
  LD E,A
  ADD A,D
  LD A,B
  JP M,PUFOUT_28
  SUB D
  SUB E
  CALL P,PUFOUT_37
  PUSH BC
  CALL PUFOUT_42
  JP PUFOUT_29

PUFOUT_28:
  CALL PUFOUT_37
  LD A,C
  CALL PUFOUT_49
  LD C,A
  XOR A
  SUB D
  SUB E
  CALL PUFOUT_37
  PUSH BC
  LD B,A
  LD C,A
PUFOUT_29:
  CALL PUFOUT_51
  POP BC
  OR C
  JP NZ,PUFOUT_30
  LD HL,(NXTOPR)
PUFOUT_30:
  ADD A,E
  DEC A
  CALL P,PUFOUT_37
  LD D,B
  JP SPCFST7

PUFOUT_31:
  PUSH HL
  PUSH DE
  CALL INT_CSNG
  POP DE
PUFOUT_32:
  CALL L3D04
  LD E,B
  RST TSTSGN
  PUSH AF
  CALL NZ,PUFOUT_63
  POP AF
  POP HL
  POP BC
  PUSH AF
  LD A,C
  OR A
  PUSH AF
  CALL NZ,DCR_A		; DEC A, RET
  ADD A,B
  LD C,A
  LD A,D
  AND $04
  CP $01
  SBC A,A
  LD D,A
  ADD A,C
  LD C,A
  SUB E
  PUSH AF
  JP P,PUFOUT_33
  CALL PUFOUT_60
  JP NZ,PUFOUT_33
  PUSH HL
  CALL SHRT1_DEC
  LD HL,FACCU
  INC (HL)
  POP HL
PUFOUT_33:
  POP AF
  PUSH BC
  PUSH AF
  JP M,PUFOUT_34
  XOR A
PUFOUT_34:
  CPL
  INC A
  ADD A,B
  INC A
  ADD A,D
  LD B,A
  LD C,$00
  CALL Z,PUFOUT_45
  CALL PUFOUT_51
  POP AF
  CALL P,PUFOUT_39
  CALL PUFOUT_47
  POP BC
  POP AF
  JP NZ,PUFOUT_35
  CALL DCXH_2
  LD A,(HL)
  CP '.'
  CALL NZ,INCHL
  LD (NXTOPR),HL
PUFOUT_35:
  POP AF
  LD A,(FACCU)
  JP Z,PUFOUT_36
  ADD A,E
  SUB B
  SUB D
PUFOUT_36:
  PUSH BC
  CALL DOEBIT
  EX DE,HL
  POP DE
  JP SPCFST7

PUFOUT_37:
  OR A
PUFOUT_38:
  RET Z
  DEC A
  LD (HL),'0'
  INC HL
  JP PUFOUT_38
PUFOUT_39:
  JP NZ,PUFOUT_41
PUFOUT_40:
  RET Z
  CALL PUFOUT_47
PUFOUT_41:
  LD (HL),'0'
  INC HL
  DEC A
  JP PUFOUT_40

PUFOUT_42:
  LD A,E
  ADD A,D
  INC A
  LD B,A
  INC A
PUFOUT_43:
  SUB $03
  JP NC,PUFOUT_43
  ADD A,$05
  LD C,A
PUFOUT_44:
  LD A,(TEMP3)
  AND $40
  RET NZ
  LD C,A
  RET

PUFOUT_45:
  DEC B
  JP P,PUFOUT_48
  LD (NXTOPR),HL
  LD (HL),'.'
PUFOUT_46:
  INC HL
  LD (HL),'0'
  INC B
  LD C,B
  JP NZ,PUFOUT_46
  INC HL
  RET

PUFOUT_47:
  DEC B
PUFOUT_48:
  JP NZ,PUFOUT_50
PUFOUT_49:
  LD (HL),'.'
  LD (NXTOPR),HL
  INC HL
  LD C,B
  RET

PUFOUT_50:
  DEC C
  RET NZ
  LD (HL),','
  INC HL
  LD C,$03
  RET

PUFOUT_51:
  PUSH DE
  PUSH HL
  PUSH BC
  CALL L3D04
  LD A,B
  POP BC
  POP HL
  LD DE,FACCU+1 
  SCF
PUFOUT_52:
  PUSH AF
  CALL PUFOUT_47
  LD A,(DE)
  JP NC,PUFOUT_53
  RRA
  RRA
  RRA
  RRA
  JP PUFOUT_54

PUFOUT_53:
  INC DE
PUFOUT_54:
  AND $0F
  ADD A,'0'
  LD (HL),A
  INC HL
  POP AF
  DEC A
  CCF
  JP NZ,PUFOUT_52
  JP PUFOUT_58

PUFOUT_55:
  PUSH DE
  LD DE,L3CFA
  LD A,$05
PUFOUT_56:
  CALL PUFOUT_47
  PUSH BC
  PUSH AF
  PUSH HL
  EX DE,HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  PUSH BC
  INC HL
  EX (SP),HL
  EX DE,HL
  LD HL,(FACLOW)
  LD B,'0'-1  ; $2F, '/'
PUFOUT_57:
  INC B
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  JP NC,PUFOUT_57
  ADD HL,DE
  LD (FACLOW),HL
  POP DE
  POP HL
  LD (HL),B
  INC HL
  POP AF
  POP BC
  DEC A
  JP NZ,PUFOUT_56
PUFOUT_58:
  CALL PUFOUT_47
  LD (HL),A
  POP DE
  RET


; Data at 15610
L3CFA:
  DEFB $10,$27,$e8,$03,$64,$00,$0a,$00,$01,$00


; Routine at 15620
;
; Used by the routines at __CSNG and PUFOUT.
L3D04:
  RST GETYPR
  LD HL,FACCU+7
  LD B,$0E
  RET NC
  LD HL,FACLOW+1
  LD B,$06
  RET

  
; This entry point is used by the routine at FOUT.
NUMPRT_SUB:
  LD (TEMP3),A
  PUSH AF
  PUSH BC
  PUSH DE
  CALL __CDBL
  LD HL,FP_ZERO
  LD A,(FACCU)
  AND A
  CALL Z,HL2FACCU
  POP DE
  POP BC
  POP AF
  LD HL,NUMSTR
  LD (HL),' '
  RET
  
PUFOUT_60:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CPL
  INC A
  LD E,A
  LD A,$01
  JP Z,PUFOUT_62
  CALL L3D04
  PUSH HL
PUFOUT_61:
  CALL SHRT1_DEC
  DEC E
  JP NZ,PUFOUT_61
  POP HL
  INC HL
  LD A,B
  RRCA
  LD B,A
  CALL BNORM_8
  CALL PUFOUT_64
PUFOUT_62:
  POP BC
  ADD A,B
  POP BC
  POP DE
  POP HL
  RET
  
PUFOUT_63:
  PUSH BC
  PUSH HL
  CALL L3D04
  LD A,(FACCU)
  SUB $40
  SUB B
  LD (FACCU),A
  POP HL
  POP BC
  OR A
  RET

PUFOUT_64:
  PUSH BC
  CALL L3D04
PUFOUT_65:
  LD A,(HL)
  AND $0F
  JP NZ,PUFOUT_66
  DEC B
  LD A,(HL)
  OR A
  JP NZ,PUFOUT_66
  DEC HL
  DEC B
  JP NZ,PUFOUT_65
PUFOUT_66:
  LD A,B
  POP BC
  RET

; Single precision exponential function
FEXP:
  CALL BCDEFP_ARG
  CALL ZERO_FACCU
  CALL STAKARG
  CALL XSTKFP
  CALL USTAKARG

; Double precision exponential function
DECEXP:
  LD A,(ARG)
  OR A
  JP Z,INTEXP_0
  LD H,A
  LD A,(FACCU)
  OR A
  JP Z,INTEXP_2
  CALL STAKFP
  CALL INTEXP_15
  JP C,DECEXP_1
  EX DE,HL
  LD (TEMP8),HL
  CALL __CDBL_1
  CALL USTAKARG
  CALL INTEXP_15
  CALL __CDBL_1
  LD HL,(TEMP8)
  JP NC,INTEXP_5
  LD A,(ARG)
  PUSH AF
  PUSH HL
  CALL ARG_FAC1
  LD HL,FBUFFR
  CALL DBL_FACCU2HL
  LD HL,FP_UNITY
  CALL HL2FACCU
  POP HL
  LD A,H
  OR A
  PUSH AF
  JP P,DECEXP_0
  XOR A
  LD C,A
  SUB L
  LD L,A
  LD A,C
  SBC A,H
  LD H,A
DECEXP_0:
  PUSH HL
  JP INTEXP_8
DECEXP_1:
  CALL __CDBL_1
  CALL ARG_FAC1
  CALL XSTKFP
  CALL __LOG
  CALL USTAKARG
  CALL DECMUL
  JP __EXP

; Integer exponential function
; FACCU=DE^HL
INTEXP:
  LD A,H
  OR L
  JP NZ,INTEXP_1
INTEXP_0:
  LD HL,$0001
  JP INT_RESULT_ONE

INTEXP_1:
  LD A,D
  OR E
  JP NZ,INTEXP_5
INTEXP_2:
  LD A,H
  RLA
  JP NC,INT_RESULT_ZERO
  JP O_ERR			; "Division by zero"
  
INT_RESULT_ZERO:
  LD HL,$0000
INT_RESULT_ONE:
  JP MAKINT

; This entry point is used by the routine at DECEXP.
INTEXP_5:
  LD (TEMP8),HL
  PUSH DE
  LD A,H
  OR A
  PUSH AF
  CALL M,INT_DIV_6
  LD B,H
  LD C,L
  LD HL,$0001
INTEXP_6:
  OR A
  LD A,B
  RRA
  LD B,A
  LD A,C
  RRA
  LD C,A
  JP NC,INTEXP_7

  CALL INTEXP_14
  JP NZ,INTEXP_10
INTEXP_7:
  LD A,B
  OR C
  JP Z,INTEXP_11
  PUSH HL
  LD H,D
  LD L,E
  CALL INTEXP_14
  EX DE,HL
  POP HL
  JP Z,INTEXP_6
  PUSH BC
  PUSH HL
  LD HL,FBUFFR
  CALL DBL_FACCU2HL
  POP HL
  CALL HL_CSNG
  CALL ZERO_FACCU
; This entry point is used by the routine at DECEXP.
INTEXP_8:
  POP BC
  LD A,B
  OR A
  RRA
  LD B,A
  LD A,C
  RRA
  LD C,A
  JP NC,INTEXP_9
  PUSH BC
  LD HL,FBUFFR
  CALL MULPHL
  POP BC
INTEXP_9:
  LD A,B
  OR C
  JP Z,INTEXP_11
  PUSH BC
  CALL STAKFP		; a.k.a. STAKFP
  LD HL,FBUFFR
  PUSH HL
  CALL HL2FACCU
  POP HL
  PUSH HL
  CALL MULPHL
  POP HL
  CALL DBL_FACCU2HL
  CALL USTAKFP
  JP INTEXP_8
  
INTEXP_10:
  PUSH BC
  PUSH DE

IF KC85 | M10
  CALL __CDBL
ENDIF

  CALL FACCU2ARG
  POP HL
  CALL HL_CSNG
  CALL ZERO_FACCU
  LD HL,FBUFFR
  CALL DBL_FACCU2HL
  CALL ARG_FAC1
  POP BC
  JP INTEXP_9
  
INTEXP_11:
  POP AF
  POP BC
  RET P
  LD A,(VALTYP)
  CP $02		; Integer ?
  JP NZ,INTEXP_12
  PUSH BC
  CALL HL_CSNG
  CALL ZERO_FACCU
  POP BC
INTEXP_12:
  LD A,(FACCU)
  OR A
  JP NZ,INTEXP_13
  LD HL,(TEMP8)
  OR H
  RET P
  LD A,L
  RRCA
  AND B
  JP OV_ERR		; "Overflow"
  
INTEXP_13:
  CALL FAC1_ARG
  LD HL,FP_UNITY
  CALL HL2FACCU
  JP DECDIV
  
INTEXP_14:
  PUSH BC
  PUSH DE
  CALL IMULT
  LD A,(VALTYP)
  CP $02			; Integer ?
  POP DE
  POP BC
  RET

; This entry point is used by the routine at DECEXP.
INTEXP_15:
  CALL ARG_FAC1
  CALL STAKARG
  CALL __INT
  CALL USTAKARG
  CALL XDCOMP
  SCF
  RET NZ
  JP CINT

; This entry point is used by the routines at PROMPT and GETVAR.
MOVUP:
  CALL ENFMEM
; This entry point is used by the routine at TESTR.
INTEXP_17:
  PUSH BC
  EX (SP),HL
  POP BC
INTEXP_18:
  RST CPDEHL
  LD A,(HL)
  LD (BC),A
  RET Z
  DEC BC
  DEC HL
  JP INTEXP_18

; Check for C levels of stack
;
; Used by the routines at __FOR, __GOSUB, EVAL_1, CLR_ALLINT and BS_ERR.
CHKSTK:
  PUSH HL
  LD HL,(STREND)
  LD B,$00
  ADD HL,BC
  ADD HL,BC

  DEFB $3E  ; "LD A,n" to Mask the next byte

; See if enough memory
ENFMEM:
  PUSH HL
  LD A,-120	; 120 Bytes minimum RAM
  SUB L
  LD L,A
  LD A,-1	; 120 Bytes (MSB) minimum RAM
  SBC A,H
  LD H,A
  JP C,OM_ERR
  ADD HL,SP
  POP HL
  RET C
; This entry point is used by the routines at RAM_INPUT, MAKTXT, CSAVEM, __CLOAD,
; CLOADM, __CLEAR, BS_ERR and __MAX.
; Clear registers and warm boot:
OM_ERR:
  CALL LINKER
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  LD DE,$0007
  JP ERROR

; This entry point is used by the routines at PROMPT, __RUN, __LCOPY, __NEW,
; __CLOAD, INXD, __MENU and BASIC.
RUN_FST:
  LD HL,(BASTXT)
  DEC HL

; This entry point is used by the routines at __RUN, KILLASC, CLOADM, __CLEAR,
; __SAVE and __MENU.
_CLVAR:
  LD (TEMP),HL

; Routine at 16175
;
; Used by the routine at __MAX.
_CLREG:
  CALL CLR_ALLINT
  LD B,$1A
  LD HL,DEFTBL
_CLREG_0:
  LD (HL),$08
  INC HL
  DEC B
  JP NZ,_CLREG_0
  
  CALL INIT_RND
  XOR A
  LD (ONEFLG),A
  LD L,A
  LD H,A
  LD (ONELIN),HL
  LD (OLDTXT),HL
  LD HL,(MEMSIZ)
  LD (FRETOP),HL
  CALL __RESTORE
  LD HL,(VARTAB)
  LD (VAREND),HL
  LD (STREND),HL
  CALL CLSALL		; Close all files
  LD A,(NLONLY)
  AND $01
  JP NZ,_CLREG_1
  LD (NLONLY),A
; This entry point is used by the routines at __EDIT and BOOT.
_CLREG_1:
  POP BC
  LD HL,(STKTOP)
  DEC HL
  DEC HL
  LD (SAVSTK),HL
  INC HL
  INC HL
  
; This entry point is used by the routine at ERESET.
STKERR:
  LD SP,HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  CALL INIT_OUTPUT
  CALL FINPRT
  XOR A
  LD H,A
  LD L,A
  LD (PRMLEN),HL
  LD (NOFUNS),A
  LD (PRMLN2),HL
  LD (FUNACT),HL
  LD (PRMSTK),HL
  LD (SUBFLG),A
  PUSH HL
  PUSH BC

; Routine at 16284
STKERR_0:
  LD HL,(TEMP)
  RET

; TIME$ ON Statement
;
; Used by the routine at KEY_STMTS.
TIME_S_ON:
  DI
  LD A,(HL)
  AND $04
  OR $01
  CP (HL)
  LD (HL),A
  JP Z,TIME_S_ON_0
  AND $04
  JP NZ,RESET_ONGSBF
TIME_S_ON_0:
  EI
  RET

; TIME$ OFF Statement
;
; Used by the routine at KEY_STMTS.
TIME_S_OFF:
  DI
  LD A,(HL)
  LD (HL),$00
  JP STOP_TRAPEVT_FLG

; TIME$ STOP Statement
;
; Used by the routines at KEY_STMTS and CLR_ALLINT.
TIME_S_STOP:
  DI
  LD A,(HL)
  PUSH AF
  OR $02		; Interrupt STOP
  LD (HL),A
  POP AF
; This entry point is used by the routine at TIME_S_OFF.
STOP_TRAPEVT_FLG:
  XOR $05 	 ; bit 0 and 2 (Interrupt occurred / Interrupt OFF)
  JP Z,SET_ONGSBF
  EI
  RET
  
; This entry point is used by the routine at __RETURN.
RETURN_TRAP:
  DI
  LD A,(HL)
  AND $05	;  bit 0 and 2 (Interrupt occurred / Interrupt OFF)
  CP (HL)
  LD (HL),A
  JP NZ,RESET_TRAPEVT_FLG
  EI
  RET
   
; This entry point is used by the routines at _RST75 and BRKCHK.
TRAPCHK:
  DI
  LD A,(HL)
  AND $01	; Interrupt OFF ?
  JP Z,NO_TRAP_EVT
  LD A,(HL)
  OR $04	; Interrupt occurred ?
  CP (HL)
  JP Z,NO_TRAP_EVT
  LD (HL),A

; Toggle bit 0 and 2 (Interrupt occurred / Interrupt OFF)
RESET_TRAPEVT_FLG:
  XOR $05	;  bit 0 and 2 (Interrupt occurred / Interrupt OFF)
  JP Z,RESET_ONGSBF
NO_TRAP_EVT:
  EI
  RET
  
; This entry point is used by the routine at TIME_S_ON.
RESET_ONGSBF:
  LD A,(ONGSBF)
  INC A
  LD (ONGSBF),A
  EI
  RET
  
; This entry point is used by the routine at CLR_ALLINT.
TIME_S_EVENT:
  DI
  LD A,(HL)
  AND $03		; are bit 0 or 1 (Interrupt OFF / Interrupt STOP) set ?
  CP (HL)
  LD (HL),A
  JP NZ,SET_ONGSBF	; no,
TIME_S_STOP_7:
  EI
  RET
  
SET_ONGSBF:
  LD A,(ONGSBF)
  SUB $01
  JP C,TIME_S_STOP_7
  LD (ONGSBF),A
  EI
  RET

; Clear all COM, TIME, and KEY interrupt definitions
;
; Used by the routines at _CLREG and __EDIT.
CLR_ALLINT:
  LD HL,TRPTBL
  LD B,$0A
  XOR A
CLR_ALLINT_0:
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CLR_ALLINT_0
  LD HL,FNKSTAT
  LD B,$08
CLR_ALLINT_1:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,CLR_ALLINT_1
  LD (ONGSBF),A
  RET
  
; This entry point is used by the routine at NEWSTT.
CLR_ALLINT_2:
  LD B,$02

  defb $11	; LD DE,NN

; Routine at 16427
;
; Used by the routine at NEWSTT.
EXEC_ONGOSUB:
  LD B,$01
  LD A,(ONEFLG)
  OR A
  RET NZ
  PUSH HL
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,CLR_ALLINT_5
  DEC B
  JP NZ,CLR_ALLINT_7
  LD HL,ON_TIME_FLG
  LD B,$09
CLR_ALLINT_3:
  LD A,(HL)
  CP $05
  JP Z,CLR_ALLINT_6
CLR_ALLINT_4:
  INC HL
  INC HL
  INC HL
  DEC B
  JP NZ,CLR_ALLINT_3
CLR_ALLINT_5:
  POP HL
  RET
  
CLR_ALLINT_6:
  PUSH BC
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  DEC HL
  LD A,D
  OR E
  POP BC
  JP Z,CLR_ALLINT_4
  PUSH DE
  PUSH HL
  CALL TIME_S_EVENT
  CALL TIME_S_STOP
  LD C,$03
  CALL CHKSTK
  POP BC
  POP DE
  POP HL
  POP AF
  JP DO_GOSUB
  
CLR_ALLINT_7:
  LD HL,TRPTBL
  LD A,(HL)
  DEC A
  JP Z,CLR_ALLINT_6
  POP HL
  RET

; Routine at 16511
;
; Used by the routine at _CLREG.
__RESTORE:
  EX DE,HL
  LD HL,(BASTXT)
  JP Z,__RESTORE_0
  EX DE,HL
  CALL ATOH
  PUSH HL
  CALL SRCHLN
  LD H,B
  LD L,C
  POP DE
  JP NC,UL_ERR
__RESTORE_0:
  DEC HL
; This entry point is used by the routine at __READ.
; a.k.a. RESFIN
UPDATA:
  LD (DATPTR),HL
  EX DE,HL
  RET

; Routine at 16538
;
; Used by the routine at CHSNS.
__STOP:
  RET NZ
  INC A
  JP __END_0

; Routine at 16543
__END:
  RET NZ
  XOR A
  LD (ONEFLG),A
  PUSH AF
  CALL Z,CLSALL		; Close all files
  POP AF
; This entry point is used by the routine at __STOP.
__END_0:
  LD (SAVTXT),HL
  LD HL,TEMPST
  LD (TEMPPT),HL
  DEFB $21	 ; "LD HL,nn" to jump over the next word without executing it

; Routine at 16563
;
; Used by the routines at __RESUME, __LINE, __INPUT and __READ.
INPBRK:
  OR $FF               ; 11111111b, Flag "Break" wanted
  POP BC               ; Return not needed and more

; This entry point is used by the routine at BASIC_MAIN.
_ENDPRG:
  LD HL,(CURLIN)       ; Get current line number
  PUSH HL              
  PUSH AF              ; Save STOP / END statusct break?
  LD A,L               ; Is it direct break?
  AND H
  INC A                ; Line is -1 if direct break
  JP Z,NOLIN           ; Yes - No line number
  LD (OLDLIN),HL       ; Save line of break
  LD HL,(SAVTXT)       ; Get point of break
  LD (OLDTXT),HL       ; Save point to CONTinue
NOLIN:
  CALL INIT_OUTPUT     ; Enable output
  CALL CONSOLE_CRLF
  POP AF
  LD HL,BREAK_MSG
  JP NZ,ERROR_REPORT_1
  JP RESTART

; Routine at 16602
__CONT:
  LD HL,(OLDTXT)        ; Get CONTinue address
  LD A,H                ; Is it zero?
  OR L
  LD DE,$0011			; Err $11 - "Can't CONTINUE"
  JP Z,ERROR
  EX DE,HL              ; Save code string address
  LD HL,(OLDLIN)        ; Get line of last break
  LD (CURLIN),HL        ; Set up current line number
  EX DE,HL              ; Restore code string address
  RET                   ; CONTinue where left off

  JP FC_ERR

; Check to see if the current character in (HL) is an alpha character
;
; Used by the routines at DEFCON and GETVAR.
; a.k.a. CHKLTR
; Load A with char in (HL) and check it is a letter:
IS_LETTER:
  LD A,(HL)             ; Get byte

; Check to see if the character in A is a letter
;
; Used by the routines at OPRND and GETVAR.
ISLETTER_A:
  CP 'A'                ; < "A" ?
  RET C                 ; Carry set if not letter
  CP $5B                ; > "Z" ?
  CCF                   
  RET                   ; Carry set if not letter

; Routine at 16633
__CLEAR:
  PUSH HL
  CALL SWAPNM_1
  POP HL
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,_CLVAR
  RST $38
  DEFB HC_CLEAR		; offset: 00, Hook for CLEAR
  
  CALL INTIDX_0  ; Get integer
  DEC HL             ; Cancel increment
  RST CHRGTB		 ; Gets next character (or token) from BASIC text.
  PUSH HL            ; Save code string address
  LD HL,(HIMEM)
  LD B,H
  LD C,L
  LD HL,(MEMSIZ)     ; Get end of RAM
  JP Z,STORED        ; No value given - Use stored
  POP HL
  RST SYNCHR 		 ; Check for comma
  DEFB ','
  PUSH DE
  CALL GETWORD
  DEC HL
  RST CHRGTB		 ; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR		 ; "Syntax error"
  EX (SP),HL         ; Save code string address
  EX DE,HL           ; Number to DE
  LD A,H             ; Get MSB of new RAM top
  AND A              ; too low ?
  JP P,FC_ERR		 ; "Illegal function call" error
  PUSH DE
  LD DE,MAXRAM+1	 ; Limit of CLEAR position
  RST CPDEHL
  JP NC,FC_ERR		 ; "Illegal function call" error
  POP DE
  PUSH HL            ; Save code string address (again)
  LD BC,$FEF5		 ; -267 (same offset on MSX)
  LD A,(MAXFIL)
__CLEAR_0:
  ADD HL,BC
  DEC A
  JP P,__CLEAR_0
  POP BC             ; Restore code string address (1st copy)
  DEC HL
STORED:
  LD A,L             ; Get LSB of new RAM top
  SUB E              ; Subtract LSB of string space
  LD E,A             ; Save LSB
  LD A,H             ; Get MSB of new RAM top
  SBC A,D            ; Subtract MSB of string space
  LD D,A             ; Save MSB
  JP C,OM_ERR		 ; ?OM Error if not enough mem
  PUSH HL            ; Save RAM top
  LD HL,(VARTAB)     ; Get program end
  PUSH BC
  LD BC,$00A0		 ; 160 Bytes minimum working RAM (same offset on MSX)
  ADD HL,BC          ; Get lowest address
  POP BC             
  RST CPDEHL         ; Enough memory?
  JP NC,OM_ERR      ; No - ?OM Error
  EX DE,HL           ; RAM top to HL
  LD (STKTOP),HL     ; Set new top of RAM
  LD H,B
  LD L,C
  LD (HIMEM),HL
  POP HL
  LD (MEMSIZ),HL     ; Set new string space
  POP HL             
  CALL _CLVAR		 ; Initialise variables
  LD A,(MAXFIL)
  CALL __MAX_0
  LD HL,(TEMP)
  JP NEWSTT

; Routine at 16756
__NEXT:
  LD DE,$0000               ; In case no index given
__NEXT_0:
  CALL NZ,GETVAR			; not end of statement, locate variable (Get index address)
  LD (TEMP),HL				; save BASIC pointer
  CALL BAKSTK				; search FOR block on stack (skip 2 words)
  JP NZ,NF_ERR				; "NEXT without FOR" error
  LD SP,HL                  ; Clear nested loops
  PUSH DE                   ; Save index address
  LD A,(HL)                 ; Get sign of STEP
  PUSH AF                   ; Save sign of STEP
  INC HL
  PUSH DE                   ; Save index address
  LD A,(HL)
  INC HL
  OR A
  JP M,__NEXT_2
  DEC A
  JP NZ,__NEXT_1
  LD BC,SYNCHR
  ADD HL,BC
__NEXT_1:
  ADD A,$04
  LD (VALTYP),A
  CALL FP_HL2DE
  EX DE,HL
  EX (SP),HL
  PUSH HL
  RST GETYPR
  JP NC,__NEXT_4
  CALL HLBCDE		; a.k.a. LOADFP_CBED
  CALL FADD
  POP HL
  CALL FAC1_HL
  POP HL
  CALL LOADFP
  PUSH HL
  CALL FCOMP
  JP __NEXT_3

__NEXT_2:
  LD BC,$000C
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  EX (SP),HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  PUSH HL
  LD L,C
  LD H,B
  CALL IADD
  LD A,(VALTYP)
  CP $02
  JP NZ,OV_ERR
  EX DE,HL
  POP HL
  LD (HL),D
  DEC HL
  LD (HL),E
  POP HL
  PUSH DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  EX (SP),HL
  CALL ICOMP
__NEXT_3:
  POP HL
  POP BC
  SUB B
  CALL LOADFP
  JP Z,KILFOR
  EX DE,HL
  LD (CURLIN),HL
  LD L,C
  LD H,B
  JP PUTFID

__NEXT_4:
  CALL DECSUB_0
  POP HL
  CALL FP_DE2HL
  POP HL
  CALL HL_ARG
  PUSH DE
  CALL XDCOMP
  JP __NEXT_3
  
; Remove "FOR" block
KILFOR:
  LD SP,HL            ; Remove "FOR" block
  LD (SAVSTK),HL      ; Code string after "NEXT"
  EX DE,HL           
  LD HL,(TEMP)        ; Get next byte in code string
  LD A,(HL)           ; More NEXTs ?
  CP ','              ; No - Do next statement
  JP NZ,NEWSTT     ; Position to index name
  RST CHRGTB		  ; Gets next character (or token) from BASIC text.
  CALL __NEXT_0       ; Re-enter NEXT routine
; < will not RETurn to here , Exit to NEWSTT (RUNCNT) or Loop >



; Line input
;
; Used by the routines at PROMPT, __PRINT, TAB, __READ, __LIST, _INLIN, _OUTDO,
; CONSOLE_CRLF and INIT_PRINT_h.
ISFLIO :
  PUSH HL
  LD HL,(PTRFIL)
  LD A,H
  OR L
  POP HL
  RET

; Send CRLF to screen or printer
;
; Used by the routines at __KEY, CATALOG, _INLIN_BRK, _INLIN_ENTER, TEL_FIND,
; TXT_ESC, TXT_CTL_Y and TXT_CTL_V.
CR_LF:
  LD A,$0D         ; CR
  RST OUTDO
  LD A,$0A         ; LF
  RST OUTDO
  RET

; Routine at 16937
;
; Used by the routines at LDIR_B, INXD, TELCOM, TEL_TERM, __MENU, SCHEDL_DE,
; TEXT and MOVE_TEXT.
__BEEP:
  LD A,$07			; BEL
  RST OUTDO
  RET

; Routine at 16941
;
; Used by the routines at TXT_CTL_W, TXT_CTL_L and TXT_CTL_C.
HOME:
  LD A,$0B			; HOME
  RST OUTDO
  RET

; Routine at 16945
;
; Used by the routines at __MENU, _PRINT_TDATE, SCHEDL_DE and __EDIT.
__CLS:
  LD A,$0C			; CLS/FF
  RST OUTDO
  RET

; Protect line 8.  An ESC T is printed.
;
; Used by the routine at DSPFNK.
L4235:
  LD A,'T'
  JP ESCA

; Unprotect line 8.  An ESC U is printed.
;
; Used by the routines at ERAFNK and DSPFNK.
RSTSYS:
  LD A,'U'
  JP ESCA

; Stop automatic scrolling.  ( ESC V )
;
; Used by the routines at __MENU and WAIT_SPC.
LOCK:
  LD A,'V'
  JP ESCA

; Resume automatic scrolling.  (ESC W)
;
; Used by the routines at TELCOM, __MENU and TXT_ESC.
UNLOCK:
  LD A,'W'
  JP ESCA

; Turn the cursor on.  An ESC P is printed.
;
; Used by the routines at FNBAR_TOGGLE, TEL_TERM and TEL_PREV.
CURSON:
  LD A,'P'
  JP ESCA

; Turn the cursor off.  An ESC Q is printed.
;
; Used by the routines at FNBAR_TOGGLE, TEL_PREV, TEL_BYE, __MENU and WAIT_SPC.
CURSOFF:
  LD A,'Q'
  JP ESCA

; Delete current line on screen.  ( ESC M )
;
; Used by the routines at DSPFNK and TXT_CTL_L.
DELLIN:
  LD A,'M'
  JP ESCA

; Insert line at current line. (ESC L)
;
; Used by the routine at TXT_CTL_C.
INSLIN:
  LD A,'L'
  JP ESCA

; Erase from cursor to end of line.  (ESC K)
;
; Used by the routines at CAS_OPNI_CO, ERAFNK, DSPFNK, INXD, MOVE_TEXT and
; TXT_CTL_V.
ERAEOL:
  LD A,'K'
  JP ESCA

; calls ESC_X
;
; Used by the routines at FNBAR_TOGGLE, ERAFNK, DSPFNK and TEL_PREV.
_ESC_X:
  LD A,'X'
  JP ESCA

; This entry point is used by the routine at DSPFNK.
; revert text only if "CAPTUR" (or "CAPTUR+1") is set
ENTREV_COND:
  OR (HL)	; test (CAPTUR) or (CAPTUR+1)
  RET Z

; calls ESC__p, Reverse mode
;
; Used by the routines at DSPFNK, ESC_L and INXD.
ENTREV:
  LD A,'p'
  JP ESCA

; calls ESC__q, Exit reverse mode
;
; Used by the routines at DSPFNK, ESC_L, INXD, __MENU, WAIT_SPC and TXT_CTL_V.
EXTREV:
  LD A,'q'

; print escape code in A
;
; Used by the routines at L4235, RSTSYS, LOCK, UNLOCK, CURSON, CURSOFF, DELLIN,
; INSLIN, ERAEOL, _ESC_X, ENTREV and POSIT.
ESCA:
  PUSH AF
  LD A,$1B	; ESC
  RST OUTDO
  POP AF
  RST OUTDO
  RET

; This entry point is used by the routines at ERAFNK and DSPFNK.
ESCA_0:
  LD HL,(ACTV_X)
  LD H,$01

; calls ESC_Y, set cursor position (H,L)
;
; Used by the routines at LINE_GFX, ERAFNK, DSPFNK, __MENU, DOTTED_FNAME,
; CURS_HOME, SHOW_TIME, TXT_ESC, TXT_CTL_I, TXT_CTL_E, TXT_CTL_T, TXT_CTL_R,
; TXT_CTL_C, MCLEAR, MOVE_TEXT, TXT_CTL_Y and TXT_CTL_V.
; H=X position, L=Y position
POSIT:
  LD A,'Y'
  CALL ESCA
  LD A,L
  ADD A,$1F			; L+31
  RST OUTDO
  LD A,H
  ADD A,$1F			; H+31
  RST OUTDO
  RET

; Erase function key display
;
; Used by the routines at FNBAR_TOGGLE, __MENU, WAIT_SPC and TXT_ESC.
ERAFNK:
  LD A,(LABEL_LN)		; Label line/8th line protect status (0=off)
  AND A
  RET Z
  CALL RSTSYS
  LD HL,(CSRX)
  PUSH HL
  CALL ESCA_0
  CALL ERAEOL
  POP HL	; cursor coordinates
  CALL POSIT
  CALL _ESC_X
  XOR A
  RET

; Set and display function keys
;
; Used by the routines at TELCOM and SCHEDL_DE.
STDSPF:
  CALL STFNK

; Display FN keys in bottom line
;
; Used by the routines at FNBAR_TOGGLE, TEL_TERM and FNKSB.
DSPFNK:
  LD HL,(CSRX)
  LD A,(ACTV_X)
  CP L
  JP NZ,DSPFNK_0
  PUSH HL
  CALL SCROLL_ALTLCD

IF M100
  LD L,$01	; cursor coordinates
ENDIF

IF KC85 | M10
  CALL HOME
ENDIF
IF M100
  CALL POSIT
ENDIF
  CALL DELLIN
  POP HL
  DEC L
DSPFNK_0:
  PUSH HL
  CALL RSTSYS
  CALL ESCA_0
  LD HL,FNKSTR
  LD E,$08
  LD A,(REVERSE)

  PUSH AF			; Save "reverse" status
  CALL EXTREV		; Exit from reverse mode
DSPFNK_1:
  LD A,(ACTV_Y)
  CP 40
  LD BC,$040C		; pos for 40 columns (4, 12)
  JP Z,DSPFNK_2
  LD BC,$0907		; pos (9,7)
DSPFNK_2:
  PUSH HL
  LD HL,CAPTUR+1		; CAPTUR+1
  LD A,E
  SUB $06				; -6
  JP Z,DSPFNK_3
  DEC A					; -7
  DEC HL				; CAPTUR
DSPFNK_3:
  CALL Z,ENTREV_COND	; revert text only if (E=6 and "CAPTUR+1" is set) or if (E=7 and "CAPTUR" is set)
  POP HL
  CALL OUTS_B_CHARS
  ADD HL,BC
  CALL EXTREV		; Exit from reverse mode
  DEC E
  CALL NZ,OUT_SPC
  JP NZ,DSPFNK_1
  CALL ERAEOL
  CALL L4235
  POP AF
  
  AND A
  CALL NZ,ENTREV	; Restore previous "reverse" status
  POP HL	; cursor coordinates
  CALL POSIT
  CALL _ESC_X
  XOR A
  RET

; Print the character in the A register to the screen. Used by RST20H
;
; Used by the routine at LCD_OUT.
OUTC_SUB0:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF

; Involved by $0020, uses HOUTD
OUTC_SUB:
  RST $38
  DEFB HC_OUTD		; Offset: 08
  
  CALL OUTC_SUB_0
  JP POPALL
  
; This entry point is used by the routine at LCD_OUTPUT.
OUTC_SUB_0:
  LD C,A
  XOR A
  LD (CRTFLG),A

IF KC85 | M10
  RST $38
  DEFB HC_LCDPUT		; offset: 10
ENDIF

IF M100
  LD A,(SCREEN)		; Console type 0=LCD 1=CRT
  AND A
  JP NZ,OUTC_SUB_3
ENDIF

  CALL OUTC_SUB_1
  LD HL,(CSRX)
  LD (CSR_ROW),HL
  RET
 
OUTC_SUB_1:
  CALL ESC_NOCURSOR
  CALL OUTC_SUB_4
; This entry point is used by the routine at ESC_J.
OUTC_SUB_2:
  LD HL,(CSRX)
  EX DE,HL
  CALL MOVE_CURSOR
  LD A,(CSR_STATUS)
  AND A
  RET Z
  JP ESC_CURSOR

IF M100
OUTC_SUB_3:
  RST $38
  DEFB HC_CRTPUT		; Offset: 60
ENDIF
  
OUTC_SUB_4:
  LD HL,ESCCNT
  LD A,(HL)
  AND A
  JP NZ,IN_ESC
  LD A,C
  
IF KC85 | M10
  CP $20
  JP C,TTY_VECT_JP_0
; This entry point is used by the routine at _TAB.
OUTC_SUB_5:
  LD HL,(CSRX)
  CP $7F
  JP Z,DELCHR
  LD C,A
ENDIF

IF M100
  LD HL,(CSRX)
  CP $09			; TAB
  JP Z,_TAB
  CP $7F			; BS
  JP Z,DELCHR
  CP ' '
  JP C,TTY_VECT_JP_0
ENDIF
  
  CALL ESC_J_1
  CALL ESC_C
  RET NZ
  LD H,$01
 
IF M100
  JP _LF
ENDIF

IF KC85 | M10
; Move down one line
;
; Used by the routine at OUTC_SUB.
_LF:
  CALL ESC_B
  RET NZ
  LD A,(NO_SCROLL)
  AND A
  RET NZ
  CALL UPD_COORDS
  CALL SCROLL_ALTLCD
  LD L,$01
  JP ESC_M_0
ENDIF


; Control code routine for LCD output (RST 20H)
;
; Used by the routine at OUTC_SUB.
TTY_VECT_JP_0:
  LD HL,ESCTBL-2  ;$4388
  LD C,$08
; This entry point is used by the routines at IN_ESC, _INLIN and MOVE_TEXT.
TTY_VECT_JP:
  INC HL
  INC HL
  DEC C
  RET M
  CP (HL)
  INC HL
  JP NZ,TTY_VECT_JP
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  PUSH HL
  LD HL,(CSRX)
  RET


; Table at $438A a.k.a. TTY_CTLCODES
ESCTBL:
  DEFB $07
  DEFW _BEEP

  DEFB $08
  DEFW _BS

  DEFB $09
  DEFW _TAB

  DEFB $0A
  DEFW _LF

  DEFB $0B
  DEFW ESC_H				; Home cursor

  DEFB $0C
  DEFW _CLS

  DEFB $0D
  DEFW CURS_CR

  DEFB $1B
  DEFW ESC_MODE

  
; This entry point is used by the routines at ESC_P, ESC_Q, ESC_M, ESC_L,
; ESC_K, ESC_J and TEL_PREV.
TEST_CRTLCD:
  LD A,(CRTFLG)
  AND A
  RET Z
  POP AF
  RET
  
; This entry point is used by the routines at ESC_M, ESC_L and ESC_J.
TEXT_LINES:
  LD A,(LABEL_LN)		; Label line/8th line protect status (0=off)
  ADD A,$08
  RET

; Set cursor position
ESC_Y:
  LD A,$02
  defb $01	; LD BC,NN

; (27), This routine puts the LCD output routine into ESCape mode
;
; Used by the routine at ESC_W.
ESC_MODE:
	;ESC_MODE+1: XOR A  ($43B3)
  LD A,$AF
  LD (ESCCNT),A
  RET

; a.k.a. TTY_ESC
ESCFN:
  DEFM "j"
  DEFW _CLS

  DEFM "E"
  DEFW _CLS

  DEFM "K"
  DEFW ESC_K

  DEFM "J"
  DEFW ESC_J

  DEFM "l"
  DEFW ESC_CLINE		; ESC,"l", clear line

  DEFM "L"
  DEFW ESC_L

  DEFM "M"
  DEFW ESC_M

  DEFM "Y"
  DEFW ESC_Y

  DEFM "A"
  DEFW ESC_A

  DEFM "B"
  DEFW ESC_B

  DEFM "C"
  DEFW ESC_C

  DEFM "D"
  DEFW ESC_D

  DEFM "H"
  DEFW ESC_H		; Home cursor

  DEFM "p"
  DEFW ESC__p

  DEFM "q"
  DEFW ESC__q

  DEFM "P"
  DEFW ESC_P

  DEFM "Q"
  DEFW ESC_Q

  DEFM "T"
  DEFW ESC_T

  DEFM "U"
  DEFW ESC_U

  DEFM "V"
  DEFW ESC_V

  DEFM "W"
  DEFW ESC_W

  DEFM "X"
  DEFW ESC_X
  

; ESCape sequence processor.
;
; Used by the routine at OUTC_SUB.
IN_ESC:
  LD A,C
  CP $1B		; ESC
  LD A,(HL)
  JP Z,DOUBLE_ESC	; ESC pressed twice
  AND A
  JP P,ESC_CURS
  CALL ESC_MODE+1
  LD A,C
  LD HL,ESCFN-2
  LD C,$16
  JP TTY_VECT_JP

ESC_CURS:
  DEC A
  LD (ESCCNT),A
  LD A,(ACTV_Y)
  LD DE,CSRY
  JP Z,ESC_CURS_0
  LD A,(ACTV_X)
  LD HL,LABEL_LN		; Label line/8th line protect status (0=off)
  ADD A,(HL)
  DEC DE
ESC_CURS_0:
  LD B,A
  LD A,C
  SUB $20	;Top left of screen is n=m=20h.
  CP B
  INC A
  LD (DE),A
  RET C
  LD A,B
  LD (DE),A
  RET

; Start inverse video mode
ESC__p:
  defb $f6		; OR $AF

; Cancel inverse video
ESC__q:
  XOR A
  LD (REVERSE),A
  RET

; Unprotect line 8
ESC_U:
  XOR A
  defb $C2	; JP NZ,NN (always false)

; Protect line 8
ESC_T:
  LD A,$FF
  LD (LABEL_LN),A		; Label line/8th line protect status (0=off)
  RET

; Stop automatic scrolling
ESC_V:
  defb $f6		; OR $AF

; Resume automatic scrolling
ESC_W:
  XOR A
  LD (NO_SCROLL),A
  RET

; This entry point is used by the routine at IN_ESC.
; ESC pressed twice
DOUBLE_ESC:
  INC HL
  LD (HL),A
  JP ESC_MODE

; ESC X
ESC_X:
  LD HL,ESCSAV
  
; This entry point is used by the routine at DSKI_S.
; (Erase last character ?)
ESC_X_0:
  LD A,(HL)
  LD (HL),$00
  DEC HL
  LD (HL),A
  RET

; Move cursor RIGHT
; Used by the routine at OUTC_SUB.
ESC_C:
  LD A,(ACTV_Y)
  CP H
  RET Z
  INC H
  JP UPD_COORDS

; Move cursor to the LEFT
; Used by the routine at _BS.
ESC_D:
  DEC H
  RET Z

ESC_SETPOS:
  JP UPD_COORDS

; Backspace routine
_BS:
  CALL ESC_D
  RET NZ
  LD A,(ACTV_Y)
  LD H,A

; Move cursor UP
ESC_A:
  DEC L
  RET Z
  JP UPD_COORDS

; Move cursor down one line
;
; Used by the routine at _LF.
ESC_B:
  CALL GET_BOTTOMROW
  CP L
  RET Z
  JP C,ESC_B_1
  INC L
; This entry point is used by the routines at ESC_X, ESC_SETPOS, ESC_A, _LF and CURS_CR.
UPD_COORDS:
  LD (CSRX),HL
  RET

ESC_B_1:
  DEC L
  XOR A
  JP UPD_COORDS

; Tab cursor
;
; Used by the routine at OUTC_SUB.
_TAB:
  LD A,(CSRY)
  PUSH AF
  LD A,' '

IF KC85 | M10
  CALL OUTC_SUB_5
ENDIF

IF M100
  RST OUTDO
ENDIF

  POP BC
  LD A,(CSRY)
  CP B
  RET Z
  DEC A
  AND $07
  JP NZ,_TAB
  RET

IF M100
; Move down one line
;
; Used by the routine at OUTC_SUB.
_LF:
  CALL ESC_B
  RET NZ
  LD A,(NO_SCROLL)
  AND A
  RET NZ
  CALL UPD_COORDS
  CALL SCROLL_ALTLCD
  LD L,$01
  JP ESC_M_0
ENDIF

; Home cursor (ESC H) and vertical tab (0Bh)
;
; Used by the routine at _CLS.
; Home cursor
ESC_H:
  LD L,$01

; Move cursor to beginning
;
; Used by the routines at ESC_M and ESC_L.
CURS_CR:
  LD H,$01
  JP UPD_COORDS

; Turn cursor on
ESC_P:
IF M100
  LD A,$01
  LD (CSR_STATUS),A
  CALL TEST_CRTLCD
  JP ESC_CURSOR
ENDIF

IF KC85 | M10
  ;LD A,$AF
  DEFB $3E  ; "LD A,n" to Mask the next byte
ENDIF


; Turn cursor off
ESC_Q:
  XOR A

IF M100
  LD (CSR_STATUS),A
  CALL TEST_CRTLCD
ENDIF

IF KC85 | M10
  LD HL,CSR_STATUS
  LD (HL),A
  CALL TEST_CRTLCD
  LD A,(HL)
  AND A
  JP NZ,ESC_CURSOR
ENDIF

  JP ESC_NOCURSOR


; Erase current line
ESC_M:
  CALL CURS_CR
; This entry point is used by the routine at _LF.
ESC_M_0:
  CALL TEST_CRTLCD
  CALL TEXT_LINES
  SUB L
  RET C
  JP Z,ESC_CLINE		; ESC,"l", clear line
ESC_M_1:
  PUSH AF
  LD H,40
ESC_M_2:
  INC L
  CALL ESC_L_2
  DEC L
  CALL DELETE_TXT_LINE
  DEC H
  JP NZ,ESC_M_2
  INC L
  POP AF
  DEC A
  JP NZ,ESC_M_1
  JP ESC_CLINE		; ESC,"l", clear line

; Insert a text line
ESC_L:
  CALL CURS_CR
  CALL TEST_CRTLCD
  CALL TEXT_LINES
  LD H,A
  SUB L
  RET C
  JP Z,ESC_CLINE		; ESC,"l", clear line
  LD L,H
ESC_L_0:
  PUSH AF
  LD H,40
ESC_L_1:
  DEC L
  CALL ESC_L_2
  INC L
  CALL DELETE_TXT_LINE
  DEC H
  JP NZ,ESC_L_1
  DEC L
  POP AF
  DEC A
  JP NZ,ESC_L_0
  JP ESC_CLINE		; ESC,"l", clear line

; This entry point is used by the routines at ESC_M and ESC_J.
ESC_L_2:
  PUSH HL
  PUSH HL
  CALL ESC_J_4
  LD C,(HL)
  POP HL
  CALL ESC_J_7
  AND (HL)
  POP HL
  RET

IF KC85 | M10
; This entry point is used by the routine at DSPFNK.
; Outputting the code for 'DELETE'
DELCHR:
  CALL _BS
  CALL TEST_CRTLCD
; This entry point is used by the routine at ESC_K.
ESC_L_4:
  XOR A
  LD C,$20

; Routine at 17650
; ESC-l, delete a whole text row
ESC_LL:
  JP DELETE_TXT_LINE
ENDIF
  
IF M100
; This entry point is used by the routine at OUTC_SUB.
; Outputting the code for 'DELETE'
DELCHR:
  LD A,(REVERSE)
  PUSH AF
  CALL EXTREV		; Exit from reverse mode
  LD A,$08
  RST OUTDO
  LD A,' '
  RST OUTDO
  LD A,$08
  RST OUTDO
  POP AF
  AND A
  RET Z
  JP ENTREV
ENDIF

; (calls ESC_l) erase current cursor line
;
; Used by the routines at ESC_M and ESC_L.
; ESC,"l", clear line
ESC_CLINE:
  LD H,$01

; Escape K routine (erase from cursor to the end of the screen)
;
; Used by the routine at ESC_J.
; erase in line
ESC_K:
  CALL TEST_CRTLCD
ESC_K_0:

IF KC85 | M10
  CALL ESC_L_4
ENDIF

IF M100
  LD C,' '
  XOR A
  CALL DELETE_TXT_LINE
ENDIF

  INC H
  LD A,H
  CP 41
  JP C,ESC_K_0
  RET

; Clear screen
_CLS:
  CALL ESC_H		; Home cursor
  CALL CLR_ALTLCD

; Erase from the cursor to the bottom of the screen
; "erase in display"
ESC_J:
  CALL TEST_CRTLCD
;ESC_J+1:  ($454F)		; ???
  ;AND D
  ;LD B,E

ESC_J_0:
  CALL ESC_K
  CALL TEXT_LINES
  CP L
  RET C
  RET Z
  LD H,$01
  INC L
  JP ESC_J_0
  
; This entry point is used by the routine at OUTC_SUB.
ESC_J_1:
  CALL TEST_CRTLCD
  LD A,(REVERSE)

; This entry point is used by the routines at ESC_M, ESC_L and ESC_K.
DELETE_TXT_LINE:
  PUSH HL
  PUSH AF
  PUSH HL
  PUSH HL
  CALL ESC_J_5
  POP HL
  CALL ESC_J_4
  LD (HL),C
  POP DE
  CALL DRAW_CHAR
  POP AF
  AND A
  POP HL
  RET Z
ESC_J_3:
  DI
  LD A,$0D		; CR
  JR NC,ESC_J_3
  CALL PUT_SHAPE
  LD A,$09		; TAB
  JR NC,ESC_J+1		; ???

; This entry point is used by the routine at ESC_L.
ESC_J_4:
  LD A,L
  ADD A,A	; *2
  ADD A,A	; *4
  ADD A,L	; *5
  ADD A,A	; *10
  ADD A,A	; *20
  ADD A,A	; *40
  LD E,A
  SBC A,A
  CPL
  LD D,A
  LD L,H
  LD H,$00
  ADD HL,DE
  LD DE,BEGLCD+256-41
  ADD HL,DE
  RET

;IF KC85 | M10	; $4562
;ESC_J_6:
;  CPL
;  AND (HL)
;  LD (HL),A
;  RET
;ENDIF

; $455B on KC85
ESC_J_5:
  LD B,A
  CALL ESC_J_7
  INC B
  DEC B
  JP Z,ESC_J_6
  OR (HL)
IF KC85 | M10
  DEFB $CA	;  JP Z,nn
ESC_J_6:
  CPL
  AND (HL)
ENDIF
  LD (HL),A
  RET

IF M100
ESC_J_6:
  CPL
  AND (HL)
  LD (HL),A
  RET
ENDIF

; This entry point is used by the routine at ESC_L.
ESC_J_7:
  LD A,L
  ADD A,A
  ADD A,A
  ADD A,L
  LD L,A	; L=L*5
  LD A,H
  DEC A
  PUSH AF
  RRCA
  RRCA
  RRCA		; A=H/8
  AND $1F	; 00011111
  ADD A,L
  LD L,A
  LD H,$00
  LD DE,TEXT_END-45
  ADD HL,DE
  POP AF
  AND $07	; 00000111
  LD D,A
  XOR A
  SCF
ESC_J_8:
  RRA
  DEC D
  JP P,ESC_J_8
  RET

IF M100
; This entry point is used by the routine at DOTTED_FNAME.
ESC_J_9:
  PUSH HL
  CALL ESC_J_7
  XOR (HL)
  LD (HL),A
  POP HL
  RET
ENDIF

; This entry point is used by the routines at _CLS and TEL_TERM.
CLR_ALTLCD:
  CALL TEST_CRTLCD
  LD A,(FNK_FLAG)
  ADD A,A
  RET P
  PUSH HL
  LD HL,ALT_LCD
  LD BC,$0140	; 40x8
ESC_J_11:
  LD (HL),' '
  INC HL
  DEC BC
  LD A,B
  OR C
  JP NZ,ESC_J_11
  POP HL
  RET

; This entry point is used by the routines at DSPFNK and _LF.
SCROLL_ALTLCD:
  CALL TEST_CRTLCD
  LD A,(FNK_FLAG)
  ADD A,A
  RET P
  LD DE,ALT_LCD
  LD HL,ALT_LCD+40
  LD BC,$0140	; 40x8
  JP _LDIR

; This entry point is used by the routines at TEL_PREV and BOOT.
ESC_J_13:
  CALL ESC_NOCURSOR
  LD L,$01
ESC_J_14:
  LD H,$01
ESC_J_15:
  CALL ESC_L_2
  CALL DELETE_TXT_LINE
  INC H
  LD A,H
  CP 41				; 'A'
  JP NZ,ESC_J_15
  INC L
  LD A,L
  CP $09			; TAB
  JP NZ,ESC_J_14
  JP OUTC_SUB_2
  
; This entry point is used by the routine at TEL_PREV.
TEL_PREV_SUB:
  LD HL,ALT_LCD
  LD E,$01
TEL_PREV_SUB_0:
  LD D,$01
TEL_PREV_SUB_1:
  PUSH HL
  PUSH DE
  LD C,(HL)
  CALL DRAW_CHAR
  POP DE
  POP HL
  INC HL
  INC D
  LD A,D
  CP 41		; ')'
  JP NZ,TEL_PREV_SUB_1
  INC E
  LD A,E
  CP $09	; TAB
  JP NZ,TEL_PREV_SUB_0
  RET

; Input line and place at KBUF.  Start with "? ". Print characters as they are
; entered
;
; Used by the routines at __INPUT, __READ, TEL_UPLD, DWNLDR, TEL_BYE and TEXT.
QINLIN:
  LD A,'?'
  RST OUTDO
  LD A,' '
  RST OUTDO

; Routine at 17988
;
; Used by the routines at PROMPT, __LINE, TELCOM_RDY, TEL_UPLD and SCHEDL_DE.
_INLIN:
  CALL ISFLIO        ; Tests if I/O to device is taking place
  JP NZ,_INLIN_FILE
  LD A,(CSRY)
  LD (SV_CSRY),A
  LD DE,KBUF
  LD B,$01
_INLIN_1:
  CALL CHGET
  LD HL,_INLIN_1
  PUSH HL
  RET C
  CP $7F		; BS
  JP Z,_INLIN_BS
  CP ' '
  JP NC,_INLIN_TTYIST
  LD HL,INLIN_TBL-2
  LD C,$07
  JP TTY_VECT_JP

INLIN_TBL:
  DEFB $03
  DEFW __INLIN_BRK
  
  DEFB $08
  DEFW _INLIN_BS

  DEFB $09
  DEFW _INLIN_TAB

  DEFB $0D
  DEFW _INLIN_ENTER

  DEFB $15
  DEFW _INLIN_CTL_UX

  DEFB $18
  DEFW _INLIN_CTL_UX

  DEFB $1D
  DEFW _INLIN_BS

; Routine at 18052
__INLIN_BRK:
  POP HL

; _INLIN Control C handler
_INLIN_BRK:
  LD A,'^'
  RST OUTDO
  LD A,'C'
  RST OUTDO
  CALL CR_LF
  LD HL,KBUF
  LD (HL),$00

IF M100
  DEC HL
  SCF
  RET
ENDIF

IF KC85 | M10
  SCF
  JP _INLIN_ENTER_0
ENDIF

; _INLIN ENTER handler
_INLIN_ENTER:
  POP HL
  CALL CR_LF
  XOR A
  LD (DE),A
_INLIN_ENTER_0:
  LD HL,BUFMIN
IF KC85 | M10
  LD (HL),','          ; a comma used, e.g. in "FILSTI"
ENDIF
  RET


; _INLIN  backspace, left arrow, control H handler
;
; Used by the routines at _INLIN, _INLIN_CTL_UX and MOVE_TEXT.
_INLIN_BS:
  LD A,B
  DEC A
  SCF
  RET Z
  DEC B
  DEC DE
  CALL INXD_1
_INLIN_BS_0:
  PUSH AF
  LD A,$7F
  RST OUTDO
  LD HL,(CSRX)
  DEC L
  DEC H
  LD A,H
  OR L
  JP Z,_INLIN_BS_1
  LD HL,CSRY
  POP AF
  CP (HL)
  JP NZ,_INLIN_BS_0
  RET

_INLIN_BS_1:
  POP AF
  SCF
  RET

; _INLIN CTRL-U handler
_INLIN_CTL_UX:
  CALL _INLIN_BS
  JP NC,_INLIN_CTL_UX
  RET

; _INLIN TAB handler
_INLIN_TAB:
  LD A,$09
; This entry point is used by the routine at _INLIN.
_INLIN_TTYIST:
  INC B
  JP Z,INXD_0
  RST OUTDO
  LD (DE),A

; Routine at 18130
INXD:
  INC DE
  RET
  
; This entry point is used by the routine at _INLIN_TAB.
INXD_0:
  DEC B
  JP __BEEP
  
; This entry point is used by the routine at _INLIN_BS.
INXD_1:
  PUSH BC
  LD A,(SV_CSRY)
  DEC B
  JP Z,INXD_5
  LD C,A
  LD HL,KBUF
INXD_2:
  INC C
  LD A,(HL)
  CP $09
  JP NZ,INXD_3
  LD A,C
  DEC A
  AND $07
  JP NZ,INXD_2
INXD_3:
  LD A,(ACTV_Y)
  CP C
  JP NC,INXD_4
  LD C,$01
INXD_4:
  INC HL
  DEC B
  JP NZ,INXD_2
  LD A,C
INXD_5:
  POP BC
  RET

; This entry point is used by the routine at _INLIN.
_INLIN_FILE:
  LD HL,(PTRFIL)
  PUSH HL
  INC HL
  INC HL
  INC HL
  INC HL
  LD A,(HL)
  SUB RAM_DEVTYPE		; D = 'RAM' device ?
  JP NZ,_INLIN_FILE_0
  LD L,A
  LD H,A
  LD (PTRFIL),HL			; Redirect I/O
  LD HL,SV_TXTPOS
  INC (HL)
  LD A,(HL)
  RRCA
  CALL NC,ENTREV	; Enter in reverse mode
  LD HL,CR_WAIT_MSG	; " Wait "
  CALL PRS
  CALL EXTREV		; Exit from reverse mode
;$4728
_INLIN_FILE_0:
  POP HL
  LD (PTRFIL),HL			; Redirect I/O
IF KC85 | M10
  LD B,$FF
ENDIF
IF M100
  LD B,$00
ENDIF
  LD HL,KBUF
_INLIN_FILE_1:
  XOR A
  LD (RAMFILE),A
  LD (RAMFILE+1),A
  CALL RDBYT
  JP C,INXD_11
  LD (HL),A
  CP $0D         	; CR
  JP Z,_INLIN_FILE_3
  CP $09			; TAB
  JP Z,_INLIN_FILE_2
  CP ' '
  JP C,_INLIN_FILE_1
_INLIN_FILE_2:
  INC HL
  DEC B
  JP NZ,_INLIN_FILE_1
_INLIN_FILE_3:
  XOR A
  LD (HL),A
  LD HL,BUFMIN
  RET
  
INXD_11:
IF M100
  LD A,B
  AND A
ENDIF

IF KC85 | M10
  INC B
ENDIF

  JP NZ,_INLIN_FILE_3
  LD A,(NLONLY)
  AND $80
  LD (NLONLY),A
  CALL CLOSE_STREAM
  LD A,$0D		; CR
  RST OUTDO
  CALL ERAEOL
  LD A,(FILFLG)
  AND A
  JP Z,INXD_12
  CALL RUN_FST
  JP NEWSTT

INXD_12:
  LD A,(EDITMODE)
  AND A
  JP NZ,__EDIT_3
  JP RESTART


; Return from 'DIM' command
; a.k.a. DIMCON
DIMRET:
  DEC HL            ; DEC 'cos GETCHR INCs        ;SEE IF COMMA ENDED THIS VARIABLE
  RST CHRGTB		; Get next character
  RET Z             ; End of DIM statement        ;IF TERMINATOR, GOOD BYE
  RST SYNCHR 		; Make sure "," follows       
  DEFB ','                                        ;MUST BE COMMA


; 'DIM' BASIC command
;
; THE "DIM" CODE SETS DIMFLG AND THEN FALLS INTO THE VARIABLE
; SEARCH ROUTINE. THE VARIABLE SEARCH ROUTINE LOOKS AT
; DIMFLG AT THREE DIFFERENT POINTS:
;
;	1) IF AN ENTRY IS FOUND, DIMFLG BEING ON INDICATES
;		A "DOUBLY DIMENSIONED" VARIABLE
;	2) WHEN A NEW ENTRY IS BEING BUILT DIMFLG'S BEING ON
;		INDICATES THE INDICES SHOULD BE USED FOR
;		THE SIZE OF EACH INDICE. OTHERWISE THE DEFAULT
;		OF TEN IS USED.
;	3) WHEN THE BUILD ENTRY CODE FINISHES, ONLY IF DIMFLG IS
;		OFF WILL INDEXING BE DONE
;
__DIM:
  LD BC,DIMRET      ; Return to "DIMRET"    ;PLACE TO COME BACK TO
  PUSH BC           ; Save on stack
  
  DEFB $F6			; "OR n" to Mask 'XOR A' (Flag "Create" variable):   NON ZERO THING MUST TURN THE MSB ON

; Get variable address to DE
;
; ROUTINE TO READ THE VARIABLE NAME AT THE CURRENT TEXT POSITION
; AND PUT A POINTER TO ITS VALUE IN [D,E]. [H,L] IS UPDATED
; TO POINT TO THE CHARACTER AFTER THE VARIABLE NAME.
; VALTYP IS SETUP. NOTE THAT EVALUATING SUBSCRIPTS IN
; A VARIABLE NAME CAN CAUSE RECURSIVE CALLS TO PTRGET SO AT
; THAT POINT ALL VALUES MUST BE STORED ON THE STACK.
; ON RETURN, [A] DOES NOT REFLECT THE VALUE OF THE TERMINATING CHARACTER
;
; Used by the routines at __LET, __LINE, __READ, EVAL_VARIABLE, __NEXT and L4F2E.
GETVAR:
  XOR A				; Find variable address,to DE            ;MAKE [A]=0
  LD (DIMFLG),A		; Set locate / create flag               ;FLAG IT AS SUCH
  LD C,(HL)			; Get First byte of name                 ;GET FIRST CHARACTER IN [C]
;GTFNAM:
  CALL IS_LETTER    ; See if a letter                       ;CHECK FOR LETTER
  JP C,SN_ERR       ; ?SN Error if not a letter             ;MUST HAVE A LETTER
  XOR A
  LD B,A            ; Clear second byte of name
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,ISSEC        ; JP if it WAS NUMERIC
  CALL ISLETTER_A   ; Check it is in the 'A'..'Z' range
  JP C,NOSEC        ; ALLOW ALPHABETICS
ISSEC:
  LD B,A
ENDNAM:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP C,ENDNAM
  CALL ISLETTER_A   ; Check it is in the 'A'..'Z' range
  JP NC,ENDNAM
NOSEC:
  CP '%'+1          ;NOT A TYPE INDICATOR
  JP NC,TABTYP      ;THEN DONT CHECK THEM
  LD DE,HAVTYP      ;SAVE JUMPS BY USING RETURN ADDRESS
  PUSH DE           
  LD D,$02          ;CHECK FOR INTEGER
  CP '%'            
  RET Z             
  INC D             ;CHECK FOR STRING
  CP '$'            
  RET Z             
  INC D             ;CHECK FOR SINGLE PRECISION
  CP '!'            
  RET Z             
  LD D,$08          ;ASSUME ITS DOUBLE PRECISION
  CP '#'            ;CHECK THE CHARACTER
  RET Z             ;WHEN WE MATCH, SETUP VALTYP
  POP AF            ;POP OFF NON-USED HAVTYP ADDRESS
TABTYP:
  LD A,C            ;GET THE STARTING CHARACTER
  AND $7F           ;GET RID OF THE USER-DEFINED FUNCTION BIT IN [C]
  LD E,A            ;BUILD A TWO BYTE OFFSET
  LD D,$00          
  PUSH HL           ;SAVE THE TEXT POINTER
  LD HL,DEFTBL-'A'  ;SEE WHAT THE DEFAULT IS
  ADD HL,DE         
  LD D,(HL)         ;GET THE TYPE OUT OF THE TABLE
  POP HL            ;GET BACK THE TEXT POINTER
  DEC HL            ;NO MARKING CHARACTER

; Routine at 18396
HAVTYP:
  LD A,D                                               ;SETUP VALTYP
  LD (VALTYP),A     ; Set variable type
  RST CHRGTB                                           ;READ PAST TYPE MARKER
  LD A,(SUBFLG)     ; Array name needed ?              ;GET FLAG WHETHER TO ALLOW ARRAYS
  DEC A                                                ;IF SUBFLG=1, "ERASE" HAS CALLED
  JP Z,ARLDSV       ; Yes - Get array name             ;PTRGET, AND SPECIAL HANDLING MUST BE DONE
  JP P,NSCFOR       ; No array with "FOR" or "FN"      ;NO ARRAYS ALLOWED
  LD A,(HL)         ; Get byte again                   ;GET CHAR BACK
  SUB '('           ; ..Subscripted variable?          ;ARRAY PERHAPS (IF SUBFLG SET NEVER WILL MATCH)
  JP Z,SBSCPT       ; Yes - Sort out subscript         ;IT IS!

  
IF M100 | KC85
  SUB '['-')'+1     ; ..Subscripted variable?          ;SEE IF LEFT BRACKET
  JP Z,SBSCPT       ; Yes - Sort out subscript         ;IF SO, OK SUBSCRIPT
ENDIF


; a.k.a. NOARYS
NSCFOR:
  XOR A               ;ALLOW PARENS AGAIN         ; Simple variable
  LD (SUBFLG),A       ;SAVE IN FLAG LOCATION      ; Clear "FOR" flag
  PUSH HL             ;SAVE THE TEXT POINTER      ; Save code string address

IF M10
  LD A,(NOFUNS)       ;ARE FUNCTIONS ACTIVE?
  OR A                
  LD (PRMFLG),A       ;INDICATE IF PARM1 NEEDS SEARCHING
  JP Z,SNFUNS         ;NO FUNCTIONS SO NO SPECIAL SEARCH
  LD HL,(PRMLEN)      ;GET THE SIZE TO SEARCH
  LD DE,PARM1         ;GET THE BASE OF THE SEARCH
  ADD HL,DE           ;[H,L]= PLACE TO STOP SEARCHING
  LD (ARYTA2),HL      ;SET UP STOPPING POINT
  EX DE,HL            ;[H,L]=START [D,E]=END
ELSE
  LD HL,(VARTAB)
ENDIF

  JP LOPFND           ;START LOOPING


LOPTOP:
  LD A,(DE)           ;GET THE VALTYP OF THIS SIMPLE VARIABLE
  LD L,A              ;SAVE SO WE KNOW HOW MUCH TO SKIP
  INC DE
  LD A,(DE)           ;[A]=FIRST CHARACTER OF THIS VARIABLE
  INC DE              ;POINT TO 2ND CHAR OF VAR NAME
  CP C                ;SEE IF OUR VARIABLE MATCHES
  JP NZ,NOTIT1
  LD A,(VALTYP)       ;GET TYPE WERE LOOKING FOR
  CP L                ;COMPARE WITH OUR VALTYP
  JP NZ,NOTIT1        ;NOT RIGHT KIND -- SKIP IT
  LD A,(DE)           ;SEE IF SECOND CHACRACTER MATCHES
  CP B
  JP Z,FINPTR         ;THAT WAS IT, ALL DONE

NOTIT1:
  INC DE

  LD H,$00            ;[H,L]=NUMBER OF BYTES TO SKIP
  ADD HL,DE           ;ADD ON THE POINTER


LOPFND:
  EX DE,HL            ;[D,E]=POINTER INTO SIMPLE VARIABLES

IF M10
  LD A,(ARYTA2)       ;ARE LOW BYTES DIFFERENT
  CP E                ;TEST
  JP NZ,LOPTOP        ;YES
  LD A,(ARYTA2+1)     ;ARE HIGH BYTES DIFFERENT
  CP D                ;THE SAME?
  JP NZ,LOPTOP        ;NO, MUST BE MORE VARS TO EXAMINE
;NOTFNS:
  LD A,(PRMFLG)       ;HAS PARM1 BEEN SEARCHED
  OR A
  JP Z,SMKVAR         ;IF SO, CREATE VARIABLE
  XOR A               ;FLAG PARM1 AS SEARCHED
  LD (PRMFLG),A
SNFUNS:
  LD HL,(VAREND)      ;STOPPING POINT IS [ARYTA2]
  LD (ARYTA2),HL
  LD HL,(VARTAB)      ;SET UP STARTING POINT
  JP LOPFND
  
ELSE

  LD A,(VAREND)
  CP E
  JP NZ,LOPTOP
  LD A,(VAREND+1)
  CP D                ;ARE HIGH BYTES DIFFERENT
  JP NZ,LOPTOP        ;THE SAME?
  JP SMKVAR           ;NO, MUST BE MORE VARS TO EXAMINE

ENDIF


;GET ADDRESS OF VARIABLE
PTRGET:
  CALL GETVAR
; Routine at 18479
VARRET:
  RET


; THIS IS EXIT FOR VARPTR AND OTHERS
VARNOT:
  LD D,A              ;ZERO [D,E]
  LD E,A
  POP BC              ;GET RID OF PUSHED [D,E]
  EX (SP),HL          ;PUT RETURN ADDRESS BACK ON STACK
  RET                 ;RETURN FROM PTRGET
  
  
SMKVAR:
  POP HL              ;[H,L]= TEXT POINTER
  EX (SP),HL          ;[H,L]= RETURN ADDRESS
  PUSH DE             ;SAVE CURRENT VARIABLE TABLE POSITION
  LD DE,VARRET        ;ARE WE RETURNING TO VARPTR?
  RST CPDEHL          ;COMPARE
  JP Z,VARNOT         ;YES.
  LD DE,COMPTR        ;RETURN HERE IF NOT FOUND
  RST CPDEHL
  POP DE              ;RESTORE THE POSITION
  JP Z,FINZER         ;MAKE FAC ZERO (ALL TYPES) AND SKIP RETURN
  EX (SP),HL          ;PUT RETURN ADDRESS BACK
  PUSH HL             ;PUT THE TEXT POINTER BACK
  PUSH BC             ;SAVE THE LOOKS
  LD A,(VALTYP)       ;GET LENGTH OF SYMBOL TABLE ENTRY
  LD C,A              ;[C]=VALTYP
  PUSH BC             ;SAVE THE VALTYP ON THE STACK
  LD B,$00            ;[B]=0
  INC BC              ;MAKE THE LENGTH INCLUDE
  INC BC              ;THE LOOKS TOO
  INC BC
  LD HL,(STREND)      ;EVERYTHING UP BY THE CURRENT END OF STORAGE
  PUSH HL             ;SAVE THIS #
  ADD HL,BC           ;ADD ON THE AMOUNT OF SPACE EXTRA NOW BEING USED
  POP BC              ;POP OFF HIGH ADDRESS TO MOVE
  PUSH HL             ;SAVE NEW CANDIDATE FOR STREND
  CALL MOVUP          ;BLOCK TRANSFER AND MAKE SURE WE ARE NOT OVERFLOWING THE STACK SPACE
  POP HL              ;[H,L]=NEW STREND
  LD (STREND),HL      ;STORE SINCE WAS OK
                      ;THERE WAS ROOM, AND BLOCK TRANSFER WAS DONE, SO UPDATE POINTERS
  LD H,B              ;GET BACK [H,L] POINTING AT THE END
  LD L,C              ;OF THE NEW VARIABLE
  LD (VAREND),HL      ;UPDATE THE ARRAY TABLE POINTE
ZEROER:
  DEC HL              ;[H,L] IS RETURNED POINTING TO THE
  LD (HL),$00         ;END OF THE VARIABLE SO WE
  RST CPDEHL          ;ZERO BACKWARDS TO [D,E] WHICH
  JP NZ,ZEROER        ;POINTS TO THE START OF THE VARIABLE
  POP DE              ;[E]=VALTYP
  LD (HL),E           ;PUT DESCRIPTION
  INC HL
  POP DE              ;OF THIS VARIABLE INTO MEMORY
  LD (HL),E
  INC HL
  LD (HL),D
  EX DE,HL            ;POINTER AT VARIABLE INTO [D,E]
FINPTR:
  INC DE              ;POINT TO VALUE OF VAR
  POP HL              ;RESTORE TEXT POINTER
  RET                 ;ALL DONE WITH THIS VAR

;
; MAKE ALL TYPES ZERO AND SKIP RETURN
;
FINZER:
  LD (FACCU),A        ;MAKE SINGLES AND DOUBLES ZERO
  LD H,A              ;MAKE INTEGERS ZERO
  LD L,A
  LD (FACLOW),HL
  RST GETYPR          ;SEE IF ITS A STRING
  JP NZ,POPHR2        ;IF NOT, DONE
  LD HL,NULL_STRING   ;MAKE IT A NULL STRING BY
  LD (FACLOW),HL      ;POINTING AT A ZERO
POPHR2:
  POP HL              ;GET THE TEXT POINTER
  RET                 ;RETURN FROM EVAL


; MULTIPLE DIMENSION CODE
;

; FORMAT OF ARRAYS IN CORE
;
; DESCRIPTOR 
;	LOW BYTE = SECOND CHARCTER (200 BIT IS STRING FLAG)
;	HIGH BYTE = FIRST CHARACTER
;	LENGTH OF ARRAY IN CORE IN BYTES (DOES NOT INCLUDE DESCRIPTOR)
;	NUMBER OF DIMENSIONS 1 BYTE FOR EACH DIMENSION 
;		STARTING WITH THE FIRST A LIST (2 BYTES EACH) OF THE MAX INDICE+1
;	THE VALUES
;
; SBSCPT (a.k.a. ISARY): Sort out subscript
; Used by the routine at GETVAR.
SBSCPT:
  PUSH HL			; Save code string address
  LD HL,(DIMFLG)
  EX (SP),HL		; Save and get code string
  LD D,A			; Zero number of dimensions

; SBSCPT loop
SCPTLP:
  PUSH DE			; Save number of dimensions
  PUSH BC			; Save array name
  CALL INTIDX		; Get subscript                 ;EVALUATE INDICE INTO [D,E]
  POP BC            ;POP OFF THE LOOKS
  POP AF			;[A] = NUMBER OF DIMENSIONS SO FAR
  EX DE,HL          ;[D,E]=TEXT POINTER <> [H,L]=INDICE
  EX (SP),HL		;PUT THE INDICE ON THE STACK <> [H,L]=VALTYP & DIMFLG   ; Save subscript value
  PUSH HL			;RESAVE VALTYP AND DIMFLG                               ; Save NAMTMP and TYPE
  EX DE,HL          ;[H,L]=TEXT POINTER
  INC A				;INCREMENT # OF DIMENSIONS                              ; Count dimensions
  LD D,A			;[D]=NUMBER OF DIMENSIONS                               ; Save in D
  LD A,(HL)			;GET TERMINATING CHARACTER                              ; Get next byte in code string
  CP ','            ;A COMMA SO MORE INDICES FOLLOW?                        ; Comma (more to come)?
  JP Z,SCPTLP       ;IF SO, READ MORE                                       ; Yes - More subscripts
  
IF M10
  RST SYNCHR 		;EXPECTED TERMINATOR?                                   ; Make sure ")" follows
  DEFB ')'          ;DO CHRGET FOR NEXT ONE
ENDIF

IF M100 | KC85
  CP ')'            ;EXPECTED TERMINATOR?                                   ; Make sure ")" follows
  JP Z,DOCHRT       ;DO CHRGET FOR NEXT ONE
  CP ']'            ;BRACKET?
  JP NZ,SN_ERR      ;NO, GIVE ERROR
ENDIF

IF M100 | KC85
DOCHRT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
ENDIF

;SUBSOK:
  LD (NXTOPR),HL    ;SAVE THE TEXT POINTER
  POP HL            ;[H,L]= VALTYP & DIMFLG
  LD (DIMFLG),HL    ;SAVE VALTYP AND DIMFLG
  LD E,$00          ;WHEN [D,E] IS POPED INTO PSW, WE DON'T WANT THE ZERO FLAG TO BE SET,
                    ;SO "ERASE" WILL HAVE A UNIQUE CONDITION
  PUSH DE           ;SAVE NUMBER OF DIMENSIONS
  
  defb $11          ; "LD DE,nn", OVER THE NEXT TWO BYTES

; Routine at 18620
;
; a.k.a. ERSFIN
; Used by the routine at HAVTYP.
ARLDSV:
  PUSH HL             ; Save code string address         ;SAVE THE TEXT POINTER
  PUSH AF             ; A = 00 , Flags set = Z,N         ;SAVE A DUMMY NUMBER OF DIMENSIONS WITH THE ZERO FLAG SET
;
; AT THIS POINT [B,C]=LOOKS. THE TEXT POINTER IS IN TEMP2.
; THE INDICES ARE ALL ON THE STACK, FOLLOWED BY THE NUMBER OF DIMENSIONS.
;
  LD HL,(VAREND)      ; Start of arrays                  ;[H,L]=PLACE TO START THE SEARCH

  DEFB $3E            ; "LD A,n" AROUND THE NEXT BYTE

; Routine at 18625
FNDARY:
  ADD HL,DE            ; Move to next array start                    ;SKIP OVER THIS ARRAY SINCE IT'S NOT THE ONE
  EX DE,HL                                                           ;[D,E]=CURRENT SEARCH POINT
  LD HL,(STREND)       ; End of arrays                               ;GET THE PLACE TO STOP INTO [H,L]
  EX DE,HL                                                           ;[H,L]=SEARCH POINT
  RST CPDEHL           ; End of arrays found?                        ;STOPPING TIME?
  JP Z,CREARY          ; Yes - Create array                          ;YES, COULDN'T FIND THIS ARRAY
  LD E,(HL)            ; Get type                                    ;GET VALTYP IN [E]
  INC HL               ; Move on
  LD A,(HL)            ; Get second byte of name                     ;GET FIRST CHARACTER
  INC HL               ; Move on
  CP C                 ; Compare with name given (second byte)       ;SEE IF IT MATCHES
  JP NZ,NXTARY         ; Different - Find next array                 ;NOT THIS ONE
  LD A,(VALTYP)                                                      ;GET TYPE OF VAR WERE LOOKING FOR
  CP E                 ; Compare type                                ;SAME AS THIS ONE?
  JP NZ,NXTARY         ; Different - Find next array                 ;NO, SKIP THIS VAR
  LD A,(HL)            ; Get first byte of name                      ;GET SECOND CHARACTER
  CP B                 ; Compare with name given (first byte)        ;ANOTHER MATCH?
NXTARY:
  INC HL               ; POINT TO SIZE ENTRY
  LD E,(HL)            ; GET VAR NAME LENGTH IN [E]
  INC HL               ; ADD ONE TO GET CORRECT LENGTH
  LD D,(HL)            ; HIGH BYTE OF ZERO
  INC HL               ; ADD OFFSET
  JP NZ,FNDARY         ; Not found - Keep looking                    ;IF NO MATCH, SKIP THIS ONE AND TRY AGAIN
  LD A,(DIMFLG)        ; Found Locate or Create it?                  ;SEE IF CALLED BY "DIM"
  OR A                                                               ;ZERO MEANS NO
  JP NZ,DD_ERR         ; Create - Err $0A - "Redimensioned array"    ;PRESERVE [D,E], AND DISPATCH TO
                                                                     ;"REDIMENSIONED VARIABLE" ERROR
                                                                     ;IF ITS "DIM" CALLING PTRGET
;
; TEMP2=THE TEXT POINTER
; WE HAVE LOCATED THE VARIABLE WE WERE LOOKING FOR
; AT THIS POINT [H,L] POINTS BEYOND THE SIZE TO THE NUMBER OF DIMENSIONS
; THE INDICES ARE ON THE STACK FOLLOWED BY THE NUMBER OF DIMENSIONS
;
  POP AF               ; Locate - Get number of dim'ns               ;[A]=NUMBER OF DIMENSIONS
  LD B,H               ; BC Points to array dim'ns                   ;SET [B,C] TO POINT AT NUMBER OF DIMENSIONS
  LD C,L
  JP Z,POPHLRT         ; Jump if array load/save                     ;"ERASE" IS DONE AT THIS POINT, SO RETURN TO DO THE ACTUAL ERASURE
  SUB (HL)             ; Same number of dimensions?                  ;MAKE SURE THE NUMBER GIVEN NOW
                                                                     ;AND WHEN THE ARRAY WAS SET UP ARE THE SAME
  JP Z,FINDEL          ; Yes - Find element                          ;JUMP OFF AND READ THE INDICES....

; Routine at 18678
;
; Used by the routine at MLDEBC and SBSCPT.
; "Subscript error"
BS_ERR:
  LD DE,$0009
  JP ERROR

;
; HERE WHEN VARIABLE IS NOT FOUND IN THE ARRAY TABLE
;
; BUILDING AN ENTRY:
; 
;	PUT DOWN THE DESCRIPTOR	
;	SETUP NUMER OF DIMENSIONS
;	MAKE SURE THERE IS ROOM FOR THE NEW ENTRY
;	REMEMBER VARPTR
;	TALLY=4 (VALTYP FOR THE EXTENDED)
;	SKIP 2 LOCS FOR LATER FILL IN -- THE SIZE
; LOOP:	GET AN INDICE
;	PUT NUMBER +1 DOWN AT VARPTR AND INCREMENT VARPTR
;	TALLY= TALLY * NUMBER+1
;	DECREMENT NUMBER-DIMS
;	JNZ	LOOP
;	CALL REASON WITH [H,L] REFLECTING LAST LOC OF VARIABLE
;	UPDATE STREND
;	ZERO BACKWARDS
;	MAKE TALLY INCLUDE MAXDIMS
;	PUT DOWN TALLY
;	IF CALLED BY DIMENSION, RETURN
;	OTHERWISE INDEX INTO THE VARIABLE AS IF IT WERE FOUND ON THE INITIAL SEARCH
;
; This entry point is used by the routine at SCPTLP.
CREARY:
  LD A,(VALTYP)       ;GET VALTYP OF NEW VAR
  LD (HL),A           ;PUT DOWN THE VARIABLE TYPE
  INC HL
  LD E,A
  LD D,$00            ;[D,E]=SIZE OF ONE VALUE (VALTYP)
  POP AF              ; Array to save or 0 dim'ns?
  JP Z,FC_ERR         ; Err $05 - "Illegal function call"
  LD (HL),C           ;PUT DOWN THE DESCRIPTOR                  ; Save second byte of name
  INC HL
  LD (HL),B                                                     ; Save first byte of name
  INC HL
  LD C,A              ; Number of dimensions to C  (=NUMBER OF TWO BYTE ENTRIES NEEDED TO STORE THE SIZE OF EACH DIMENSION)
  CALL CHKSTK         ; Check if enough memory                  ;GET SPACE FOR DIMENSION ENTRIES
  INC HL              ; Point to number of dimensions           ;SKIP OVER THE SIZE LOCATIONS
  INC HL
  LD (TEMP3),HL       ; Save address of pointer      ;SAVE THE LOCATION TO PUT THE SIZE IN -- POINTS AT THE NUMBER OF DIMENSIONS
  LD (HL),C           ; Set number of dimensions     ;STORE THE NUMBER OF DIMENSIONS
  INC HL
  LD A,(DIMFLG)       ; Locate of Create?            ;CALLED BY DIMENSION?
  RLA                 ; Carry set = Create           ;SET CARRY IF SO
  LD A,C              ; Get number of dimensions     ;[A]=NUMBER OF DIMENSIONS
CRARLP:
  LD BC,10+1          ; Default dimension size 10
  JP NC,DEFSIZ        ; Locate - Set default size       ;DEFAULT DIMENSIONS TO TEN
  POP BC              ; Get specified dimension size    ;POP OFF AN INDICE INTO [B,C]
  INC BC              ; Include zero element            ;ADD ONE TO IT FOR THE ZERO ENTRY
DEFSIZ:
  LD (HL),C           ; Save LSB of dimension size      ;PUT THE MAXIMUM DOWN
  PUSH AF             ; Save num' of dim'ns an status   ;SAVE THE NUMBER OF DIMENSIONS AND DIMFLG (CARRY)
  INC HL              
  LD (HL),B           ; Save MSB of dimension size
  INC HL
  CALL MLDEBC         ; Multiply DE by BC to find amount of mem needed   ;MULTIPLY [B,C]=NEWMAX BY CURTOL=[D,E]
  POP AF              ; Restore number of dimensions      ;GET THE NUMBER OF DIMENSIONS AND DIMFLG (CARRY) BACK
  DEC A               ; Count them                        ;DECREMENT THE NUMBER OF DIMENSIONS LEFT
  JP NZ,CRARLP        ; Do next dimension if more         ;HANDLE THE OTHER INDICES
  PUSH AF             ; Save locate/create flag           ;SAVE DIMFLG (CARRY)
  LD B,D              ; MSB of memory needed              ;[B,C]=SIZE
  LD C,E              ; LSB of memory needed
  EX DE,HL                                                ;[D,E]=START OF VALUES
  ADD HL,DE           ; Add bytes to array start          ;[H,L]=END OF VALUES
  JP C,OM_ERR         ; Too big - Error                   ;OUT OF MEMORY POINTER BEING GENERATED?
  CALL ENFMEM         ; See if enough memory              ;SEE IF THERE IS ROOM FOR THE VALUES
  LD (STREND),HL      ; Save new end of array             ;UPDATE THE END OF STORAGE

ZERARY:
  DEC HL              ; Back through array data           ;ZERO THE NEW ARRAY
  LD (HL),$00         ; Set array element to zero
  RST CPDEHL          ; All elements zeroed?              ;BACK AT THE BEGINNING?
  JP NZ,ZERARY        ; No - Keep on going                ;NO, ZERO MORE
  INC BC              ; Number of bytes + 1               ;ADD ONE TO THE SIZE TO INCLUDE THE BYTE FOR THE NUMBER OF DIMENSIONS
  LD D,A              ; A=0                               ;[D]=ZERO
  LD HL,(TEMP3)       ; Get address of array              ;GET A POINTER AT THE NUMBER OF DIMENSIONS
  LD E,(HL)           ; Number of dimensions              ;[E]=NUMBER OF DIMENSIONS
  EX DE,HL            ; To HL                             ;[H,L]=NUMBER OF DIMENSIONS
  ADD HL,HL           ; Two bytes per dimension size      ;[H,L]=NUMBER OF DIMENSIONS TIMES TWO
  ADD HL,BC           ; Add number of bytes               ;ADD ON THE SIZE TO GET THE TOTAL NUMBER OF BYTES USED
  EX DE,HL            ; Bytes needed to DE                ;[D,E]=TOTAL SIZE
  DEC HL                                                  ;BACK UP TO POINT TO LOCATION TO PUT
  DEC HL                                                  ;THE SIZE OF THE ARRAY IN BYTES IN.
  LD (HL),E           ; Save LSB of bytes needed          ;PUT DOWN THE SIZE
  INC HL              
  LD (HL),D           ; Save MSB of bytes needed
  INC HL
  POP AF              ; Locate / Create?                  ;GET BACK DIMFLG (CARRY) AND SET [A]=0
  JP C,ENDDIM         ; A is 0 , End if create

;
; AT THIS POINT [H,L] POINTS BEYOND THE SIZE TO THE NUMBER OF DIMENSIONS
; STRATEGY:
;	NUMDIM=NUMBER OF DIMENSIONS
;	CURTOL=0
; INLPNM:GET A NEW INDICE
;	POP NEW MAX INTO CURMAX
;	MAKE SURE INDICE IS NOT TOO BIG
;	MUTLIPLY CURTOL BY CURMAX
;	ADD INDICE TO CURTOL
;	NUMDIM=NUMDIM-1
;	JNZ	INLPNM
;	USE CURTOL*4 (VALTYP FOR EXTENDED) AS OFFSET
;
; a.k.a. GETDEF  
; This entry point is used by the routine at SCPTLP.
FINDEL:
  LD B,A              ; Find array element             ;[B,C]=CURTOL=ZERO
  LD C,A
  LD A,(HL)           ; Number of dimensions           ;[A]=NUMBER OF DIMENSIONS
  INC HL                                               ;POINT PAST THE NUMBER OF DIMENSIONS
  DEFB $16            ; "LD D,n" to skip "POP HL"      ;"MVI D," AROUND THE NEXT BYTE
  
INLPNM:
  POP HL              ; Address of next dim' size      ;[H,L]= POINTER INTO VARIABLE ENTRY
  LD E,(HL)           ; Get LSB of dim'n size          ;[D,E]=MAXIMUM FOR THE CURRENT INDICE
  INC HL              
  LD D,(HL)           ; Get MSB of dim'n size
  INC HL              
  EX (SP),HL          ; Save address - Get index       ;[H,L]=CURRENT INDICE, POINTER INTO THE VARIABLE GOES ON THE STACK
  PUSH AF             ; Save number of dim'ns          ;SAVE THE NUMBER OF DIMENSIONS
  RST CPDEHL          ; Dimension too large?           ;SEE IF THE CURRENT INDICE IS TOO BIG
  JP NC,BS_ERR		  ; Yes - ?BS Error                ;IF SO "BAD SUBSCRIPT" ERROR
  CALL MLDEBC         ; Multiply previous by size      ;CURTOL=CURTOL*CURRENT MAXIMUM
  ADD HL,DE           ; Add index to pointer           ;ADD THE INDICE TO CURTOL
  POP AF              ; Number of dimensions           ;GET THE NUMBER OF DIMENSIONS IN [A]
  DEC A               ; Count them                     ;SEE IF ALL THE INDICES HAVE BEEN PROCESSED
  LD B,H              ; MSB of pointer                 ;[B,C]=CURTOL IN CASE WE LOOP BACK
  LD C,L              ; LSB of pointer
  JP NZ,INLPNM        ; More - Keep going              ;PROCESS THE REST OF THE INDICES
  LD A,(VALTYP)       ; SEE HOW BIG THE VALUES ARE AND MULTIPLY BY THAT SIZE
  LD B,H              ; SAVE THE ORIGINAL VALUE FOR MULTIPLYING
  LD C,L              ; BY THREE
  ADD HL,HL           ; MULTIPLY BY TWO AT LEAST
  SUB $04             ; FOR INTEGERS AND STRINGS NO MORE MULTIPLYING BY TWO
  JP C,SMLVAL
  ADD HL,HL           ;NOW MULTIPLIED BY FOUR
  JP Z,DONMUL         ;IF SINGLE ALL DONE
  ADD HL,HL           ;BY EIGHT FOR DOUBLES
SMLVAL:
  OR A                ;FIX CC'S FOR Z-80
  JP PO,DONMUL        ;FOR STRINGS
  ADD HL,BC           ;ADD IN THE ORIGINAL
DONMUL:
  POP BC              ; Start of array                 ;POP OFF THE ADDRESS OF WHERE THE VALUES BEGIN
  ADD HL,BC           ; Point to element               ;ADD IT ONTO CURTOL TO GET THE PLACE THE VALUE IS STORED
  EX DE,HL            ; Address of element to DE       ;RETURN THE POINTER IN [D,E]

; a.k.a. FINNOW
ENDDIM:               
  LD HL,(NXTOPR)      ; Got code string address        ;REGET THE TEXT POINTER
  RET


; PRINT USING
;
; PRINT#<filenumber>,[USING<string exp>;]<list of exps>
; To write data to a sequential disk file.
;
; COME HERE AFTER THE "USING" CLAUSE IN A PRINT STATEMENT IS RECOGNIZED.
; THE IDEA IS TO SCAN THE USING STRING UNTIL THE VALUE LIST IS EXHAUSTED,
; FINDING STRING AND NUMERIC FIELDS TO PRINT VALUES OUT OF THE LIST IN,
; AND JUST OUTPUTING ANY CHARACTERS THAT AREN'T PART OF A PRINT FIELD.
;
; Routine at 18833
;
; Used by the routine at __PRINT.
USING:
  CALL EVAL_0         ;EVALUATE THE "USING" STRING
IF M100 | M10
  CALL TSTSTR         ;MAKE SURE IT IS A STRING
ENDIF
IF KC85
  CALL _TSTSTR        ;MAKE SURE IT IS A STRING
ENDIF
  RST SYNCHR
  DEFB ';'            ;MUST BE DELIMITED BY A SEMI-COLON
  EX DE,HL            ;[D,E]=TEXT POINTER
  LD HL,(FACLOW)      ;GET POINTER TO "USING" STRING DESCRIPTOR
  JP USING_1          ;DONT POP OFF OR LOOK AT USFLG

REUSST:
  LD A,(FLGINP)       ;DID WE PRINT OUT A VALUE LAST SCAN?
  OR A                ;SET CC'S
  JP Z,FCERR3         ;NO, GIVE ERROR
  POP DE              ;[D,E]=POINTER TO "USING" STRING DESCRIPTOR
  EX DE,HL            ;[D,E]=TEXT POINTER
USING_1:              
  PUSH HL             ;SAVE THE POINTER TO "USING" STRING DESCRIPTOR
  XOR A               ;INITIALLY INDICATE THERE ARE MORE VALUES IN THE VALUE LIST
  LD (FLGINP),A       ;RESET THE FLAG THAT SAYS VALUES PRINTED
  INC A               ;TURN THE ZERO FLAG OFF TO INDICATE THE VALUE LIST HASN'T ENDED
  PUSH AF             ;SAVE FLAG INDICATING WHETHER THE VALUE LIST HAS ENDED
  PUSH DE             ;SAVE THE TEXT POINTER INTO THE VALUE LIST
  LD B,(HL)           ;[B]=LENGTH OF THE "USING" STRING
  INC B               ;SEE IF ITS ZERO
  DEC B
FCERR3:
  JP Z,FC_ERR         ;IF SO, "ILLEGAL FUNCTION CALL"
  INC HL              ;[H,L]=POINTER AT THE "USING" STRING'S
  LD A,(HL)           ;DATA
  INC HL
  LD H,(HL)
  LD L,A
  JP PRCCHR           ;GO INTO THE LOOP TO SCAN THE "USING" STRING

BGSTRF:
  LD E,B              ;SAVE THE "USING" STRING CHARACTER COUNT
  PUSH HL             ;SAVE THE POINTER INTO THE "USING" STRING
  LD C,$02            ;THE \\ STRING FIELD HAS 2 PLUS NUMBER OF ENCLOSED SPACES WIDTH
LPSTRF:               
  LD A,(HL)           ;GET THE NEXT CHARACTER
  INC HL              ;ADVANCE THE POINTER AT THE "USING" STRINGDATA
  CP '\\'             ;THE FIELD TERMINATOR?
  JP Z,ISSTRF         ;GO EVALUATE A STRING AND PRINT
  CP ' '              ;A FIELD EXTENDER?
  JP NZ,NOSTRF        ;IF NOT, ITS NOT A STRING FIELD
  INC C               ;INCREMENT THE FIELD WIDTH
  DEC B               ;SEE IF THERE ARE MORE CHARACTERS
  JP NZ,LPSTRF        ;KEEP SCANNING FOR THE FIELD TERMINATOR
;
; SINCE  STRING FIELD WASN'T FOUND, THE "USING" STRING 
; CHARACTER COUNT AND THE POINTER INTO IT'S DATA MUST
; BE RESTORED AND THE "\" PRINTED
;
NOSTRF:
  POP HL              ;RESTORE THE POINTER INTO "USING" STRING'S DATA
  LD B,E              ;RESTORE THE "USING" STRING CHARACTER COUNT
  LD A,'\\'           ;RESTORE THE CHARACTER

;
; HERE TO PRINT THE CHARACTER IN [A] SINCE IT WASN'T PART OF ANY FIELD
;
NEWUCH:
  CALL PLS_PRNT       ;IF A "+" CAME BEFORE THIS CHARACTER MAKE SURE IT GETS PRINTED
  RST OUTDO           ;PRINT THE CHARACTER THAT WASN'T PART OF A FIELD
PRCCHR:
  XOR A               ;SET [D,E]=0 SO IF WE DISPATCH
  LD E,A              ;SOME FLAGS ARE ALREADY ZEROED
  LD D,A              ;DON'T PRINT "+" TWICE
PLSFIN:
  CALL PLS_PRNT       ;ALLOW FOR MULTIPLE PLUSES IN A ROW
  LD D,A              ;SET "+" FLAG
  LD A,(HL)           ;GET A NEW CHARACTER
  INC HL              
  CP '!'              ;CHECK FOR A SINGLE CHARACTER
  JP Z,SMSTRF         ;STRING FIELD
  CP '#'              ;CHECK FOR THE START OF A NUMERIC FIELD 
  JP Z,NUMNUM         ;GO SCAN IT
;;  CP '&'                   ;SEE IF ITS A VARIABLE LENGTH STRING FIELD
;;  JP Z,VARSTR              ;GO PRINT ENTIRE STRING
  DEC B               ;ALL THE OTHER POSSIBILITIES REQUIRE AT LEAST 2 CHARACTERS
  JP Z,REUSIN         ;IF THE VALUE LIST IS NOT EXHAUSTED GO REUSE "USING" STRING
  CP '+'              ;A LEADING "+" ?
  LD A,$08            ;SETUP [D] WITH THE PLUS-FLAG ON IN
  JP Z,PLSFIN         ;CASE A NUMERIC FIELD STARTS
  DEC HL              ;POINTER HAS ALREADY BEEN INCREMENTED
  LD A,(HL)           ;GET BACK THE CURRENT CHARACTER
  INC HL              ;REINCREMENT THE POINTER
  CP '.'              ;NUMERIC FIELD WITH TRAILING DIGITS
  JP Z,DOTNUM         ;IF SO GO SCAN WITH [E]=NUMBER OF DIGITS BEFORE THE "."=0
  CP '\\'             ;CHECK FOR A BIG STRING FIELD STARTER
  JP Z,BGSTRF         ;GO SEE IF IT REALLY IS A STRING FIELD
  CP (HL)             ;SEE IF THE NEXT CHARACTER MATCHES THE CURRENT ONE
  JP NZ,NEWUCH        ;IF NOT, CAN'T HAVE $$ OR ** SO ALL THE POSSIBILITIES ARE EXHAUSTED
  CP '$'              ;IS IT $$ ?
  JP Z,DOLRNM         ;GO SET UP THE FLAG BIT
  CP '*'              ;IS IT ** ?
  JP NZ,NEWUCH        ;IF NOT, ITS NOT PART OF A FIELD SINCE ALL THE POSSIBILITIES HAVE BEEN TRIED
  INC HL              ;SEE IF THE "USING" STRING IS LONG
  LD A,B              ;CHECK FOR $
  CP $02              ;ENOUGH FOR THE SPECIAL CASE OF
  JP C,_NOTSPC        ; **$
  LD A,(HL)
  CP '$'              ;IS THE NEXT CHARACTER $ ?
_NOTSPC:
  LD A,32             ;SET THE ASTERISK BIT
  JP NZ,SPCNUM        ;IF IT NOT THE SPECIAL CASE, DON'T SET THE DOLLAR SIGN FLAG
  DEC B               ;DECREMENT THE "USING" STRING CHARACTER COUNT TO TAKE THE $ INTO CONSIDERATION
  INC E               ;INCREMENT THE FIELD WIDTH FOR THE FLOATING DOLLAR SIGN

  DEFB $FE		; CP AFh ..hides the "XOR A" instruction (MVI SI,  IN 8086)

DOLRNM:
  XOR A               ;CLEAR [A]
  ADD A,$10           ;SET BIT FOR FLOATING DOLLAR SIGN FLAG
  INC HL              ;POINT BEYOND THE SPECIAL CHARACTERS
SPCNUM:
  INC E               ;SINCE TWO CHARACTERS SPECIFY THE FIELD SIZE, INITIALIZE [E]=1
  ADD A,D             ;PUT NEW FLAG BITS IN [A]
  LD D,A              ;INTO [D]. THE PLUS FLAG MAY HAVE ALREADY BEEN SET
NUMNUM:
  INC E               ;INCREMENT THE NUMBER OF DIGITS BEFORE THE DECIMAL POINT
  LD C,$00            ;SET THE NUMBER OF DIGITS AFTER THE DECIMAL POINT = 0
  DEC B               ;SEE IF THERE ARE MORE CHARACTERS
  JP Z,ENDNUS         ;IF NOT, WE ARE DONE SCANNING THIS NUMERIC FIELD
  LD A,(HL)           ;GET THE NEW CHARACTER
  INC HL              ;ADVANCE THE POINTER AT THE "USING" STRING DATA
  CP '.'              ;DO WE HAVE TRAILING DIGITS?
  JP Z,AFTDOT         ;IF SO, USE SPECIAL SCAN LOOP
  CP '#'              ;MORE LEADING DIGITS ?
  JP Z,NUMNUM         ;INCREMENT THE COUNT AND KEEP SCANNING
  CP ','
  JP NZ,FINNUM
  LD A,D              ;TURN ON THE COMMA BIT
  OR 64
  LD D,A
  JP NUMNUM           ;GO SCAN SOME MORE
  
;
; HERE WHEN A "." IS SEEN IN THE "USING" STRING
; IT STARTS A NUMERIC FIELD IF AND ONLY IF
; IT IS FOLLOWED BY A "#"
;
DOTNUM:
  LD A,(HL)           ;GET THE CHARACTER THAT FOLLOWS
  CP '#'              ;IS THIS A NUMERIC FIELD?
  LD A,'.'            ;IF NOT, GO BACK AND PRINT "."
  JP NZ,NEWUCH
  LD C,$01            ;INITIALIZE THE NUMBER OF DIGITS AFTER THE DECIMAL POINT
  INC HL
AFTDOT:
  INC C               ;INCREMENT THE NUMBER OF DIGITS AFTER THE DECIMAL POINT
  DEC B               ;SEE IF THE "USING" STRING HAS MORE
  JP Z,ENDNUS         ;CHARACTERS, AND IF NOT, STOP SCANNING
  LD A,(HL)           ;GET THE NEXT CHARACTER
  INC HL
  CP '#'              ;MORE DIGITS AFTER THE DECIMAL POINT?
  JP Z,AFTDOT         ;IF SO, INCREMENT THE COUNT AND KEEP SCANNING
;
; CHECK FOR THE "^^^^" THAT INDICATES SCIENTIFIC NOTATION
;
FINNUM:
  PUSH DE             ;SAVE [D]=FLAGS AND [E]=LEADING DIGITS
  LD DE,NOTSCI        ;PLACE TO GO IF ITS NOT SCIENTIFIC
  PUSH DE             ;NOTATION
  LD D,H              ;REMEMBER [H,L] IN CASE
  LD E,L              ;ITS NOT SCIENTIFIC NOTATION
  CP '^'              ;IS THE FIRST CHARACTER "^" ?
  RET NZ
  CP (HL)             ;IS THE SECOND CHARACTER "^" ?
  RET NZ
  INC HL
  CP (HL)             ;IS THE THIRD CHARACTER "^" ?
  RET NZ
  INC HL
  CP (HL)             ;IS THE FOURTH CHARACTER "^" ?
  RET NZ
  INC HL
  LD A,B              ;WERE THERE ENOUGH CHARACTERS FOR "^^^^"
  SUB $04             ;IT TAKES FOUR
  RET C
  POP DE              ;POP OFF THE NOTSCI RETURN ADDRESS
  POP DE              ;GET BACK [D]=FLAGS [E]=LEADING DIGITS
  LD B,A              ;MAKE [B]=NEW CHARACTER COUNT
  INC D               ;TURN ON THE SCIENTIFIC NOTATION FLAG
  INC HL

  DEFB $CA            ; JP Z,nn  to mask the next 2 bytes    ;SKIP THE NEXT TWO BYTES WITH "JZ"

NOTSCI:  
  EX DE,HL            ;RESTORE THE OLD [H,L]
  POP DE              ;GET BACK [D]=FLAGS [E]=LEADING DIGITS
  
ENDNUS:
  LD A,D              ;IF THE LEADING PLUS FLAG IS ON
  DEC HL
  INC E               ;INCLUDE LEADING "+" IN NUMBER OF DIGITS
  AND $08             ;DON'T CHECK FOR A TRAILING SIGN
  JP NZ,ENDNUM        ;ALL DONE WITH THE FIELD IF SO IF THERE IS A LEADING PLUS
  DEC E               ;NO LEADING PLUS SO DON'T INCREMENT THE NUMBER OF DIGITS BEFORE THE DECIMAL POINT
  LD A,B
  OR A                ;SEE IF THERE ARE MORE CHARACTERS
  JP Z,ENDNUM         ;IF NOT, STOP SCANNING
  LD A,(HL)           ;GET THE CURRENT CHARACTER
  SUB '-'             ;TRAIL MINUS?
  JP Z,SGNTRL         ;SET THE TRAILING SIGN FLAG
  CP '+'-'-'          ;A TRAILING PLUS?
  JP NZ,ENDNUM        ;IF NOT, WE ARE DONE SCANNING
  LD A,$08            ;TURN ON THE POSITIVE="+" FLAG
SGNTRL:
  ADD A,$04           ;TURN ON THE TRAILING SIGN FLAG
  ADD A,D             ;INCLUDE WITH OLD FLAGS
  LD D,A
  DEC B               ;DECREMENT THE "USING" STRING CHARACTER COUNT TO ACCOUNT FOR THE TRAILING SIGN
ENDNUM:
  POP HL              ;[H,L]=THE OLD TEXT POINTER
  POP AF              ;POP OFF FLAG THAT SAYS WHETHER THERE ARE MORE VALUES IN THE VALUE LIST
  JP Z,FLDFIN         ;IF NOT, WE ARE DONE WITH THE "PRINT"
  PUSH BC             ;SAVE [B]=# OF CHARACTERS REMAINING IN "USING" STRING AND [C]=TRAILING DIGITS
  PUSH DE             ;SAVE [D]=FLAGS AND [E]=LEADING DIGITS
  CALL EVAL           ;READ A VALUE FROM THE VALUE LIST
  POP DE              ;[D]=FLAGS & [E]=# OF LEADING DIGITS
  POP BC              ;[B]=# CHARACTER LEFT IN "USING" STRING
                      ;[C]=NUMBER OF TRAILING DIGITS
  PUSH BC             ;SAVE [B] FOR ENTERING SCAN AGAIN
  PUSH HL             ;SAVE THE TEXT POINTER
  LD B,E              ;[B]=# OF LEADING DIGITS
  LD A,B              ;MAKE SURE THE TOTAL NUMBER OF DIGITS
  ADD A,C             ;DOES NOT EXCEED TWENTY-FOUR
  CP 25
  JP NC,FC_ERR        ;IF SO, Err $05 - "Illegal function call"
  
  LD A,D              ;[A]=FLAG BITS
  OR $80              ;TURN ON THE "USING" BIT
  CALL FOUT_0         ;PRINT THE VALUE
  CALL PRS            ;ACTUALLY PRINT IT

FNSTRF:
  POP HL              ;GET BACK THE TEXT POINTER
  DEC HL              ;SEE WHAT THE TERMINATOR WAS
  RST CHRGTB          
  SCF                 ;SET FLAG THAT CRLF IS DESIRED
  JP Z,CRDNUS         ;IF IT WAS A END-OF-STATEMENT, FLAG THAT THE VALUE LIST ENDED AND THAT CRLF SHOULD BE PRINTED
  LD (FLGINP),A       ;FLAG THAT VALUE HAS BEEN PRINTED.
                      ;DOESNT MATTER IF ZERO SET, [A] MUST BE NON-ZERO OTHERWISE
  CP ';'              ;A SEMI-COLON?
  JP Z,SEMUSN         ;A LEGAL DELIMITER
  CP ','              ;A COMMA ?
  JP NZ,SN_ERR        ;THE DELIMETER WAS ILLEGAL

SEMUSN:
  RST CHRGTB          ;IS THERE ANOTHER VALUE?
CRDNUS:               
  POP BC              ;[B]=CHARACTERS REMAINING IN "USING" STRING
  EX DE,HL            ;[D,E]=TEXT POINTER
  POP HL              ;[H,L]=POINT AT THE "USING" STRING
  PUSH HL             ;DESCRIPTOR. RESAVE IT.
  PUSH AF             ;SAVE THE FLAG THAT INDICATES WHETHER OR NOT THE VALUE LIST TERMINATED
  PUSH DE             ;SAVE THE TEXT POINTER

;
; SINCE FRMEVL MAY HAVE FORCED GARBAGE COLLECTION
; WE HAVE TO USE THE NUMBER OF CHARACTERS ALREADY SCANNED
; AS AN OFFSET TO THE POINTER TO THE "USING" STRING'S DATA
; TO GET A NEW POINTER TO THE REST OF THE CHARACTERS TO BE SCANNED
;
  LD A,(HL)           ;GET THE "USING" STRING'S LENGTH
  SUB B               ;SUBTRACT THE NUMBER OF CHARACTERS ALREADY SCANNED
  INC HL              ;[H,L]=POINTER AT
  LD D,$00            ;THE "USING" STRING'S
  LD E,A              ;STRING DATA
  LD A,(HL)
  INC HL
  LD H,(HL)           ;SETUP [D,E] AS A DOUBLE BYTE OFFSET
  LD L,A
  ADD HL,DE           ;ADD ON THE OFFSET TO GET THE NEW POINTER
;CHKUSI:
  LD A,B              ;[A]=THE NUMBER OF CHARACTERS LEFT TO SCAN
  OR A                ;SEE IF THERE ARE ANY LEFT
  JP NZ,PRCCHR        ;IF SO, KEEP SCANNING
  JP FINUSI           ;SEE IF THERE ARE MORE VALUES

REUSIN:
  CALL PLS_PRNT       ;PRINT A "+" IF NECESSARY
  RST OUTDO           ;PRINT THE FINAL CHARACTER
FINUSI:               
  POP HL              ;POP OFF THE TEXT POINTER
  POP AF              ;POP OFF THE INDICATOR OF WHETHER OR NOT THE VALUE LIST HAS ENDED
  JP NZ,REUSST        ;IF NOT, REUSE THE "USING" STRING

FLDFIN:
  CALL C,OUTDO_CRLF   ;IF NOT COMMA OR SEMI-COLON ENDED THE VALUE LIST, PRINT A CRLF
  EX (SP),HL          ;SAVE THE TEXT POINTER <> [H,L]=POINT AT THE "USING" STRING'S DESCRIPTOR
  CALL GSTRHL         ;FINALLY FREE IT UP
  POP HL              ;GET BACK THE TEXT POINTER
  JP FINPRT           ;ZERO [PTRFIL]

; ;
; ; HERE TO HANDLE VARIABLE LENGTH STRING FIELD SPECIFIED WITH "&"
; ;
; VARSTR:
;   LD C,$00             ;SET LENGTH TO MAXIMUM POSSIBLE
;   JP ISSTRF_0

;
; HERE WHEN THE "!" INDICATING A SINGLE CHARACTER STRING FIELD HAS BEEN SCANNED
;
SMSTRF:
  LD C,$01            ;SET THE FIELD WIDTH TO 1
  DEFB $3E            ; "LD A,n" to Mask the next byte      ;SKIP NEXT BYTE WITH A "MVI A,"

ISSTRF:
  POP AF              ;GET RID OF THE [H,L] THAT WAS BEING SAVED IN CASE THIS WASN'T A STRING FIELD

;ISSTRF_0
  DEC B               ;DECREMENT THE "USING" STRING CHARACTER COUNT
  CALL PLS_PRNT       ;PRINT A "+" IF ONE CAME BEFORE THE FIELD
  POP HL              ;TAKE OFF THE TEXT POINTER
  POP AF              ;TAKE OFF THE FLAG WHICH SAYS WHETHER THERE ARE MORE VALUES IN THE VALUE LIST
  JP Z,FLDFIN         ;IF THERE ARE NO MORE VALUES THEN WE ARE DONE
  PUSH BC             ;SAVE [B]=NUMBER OF CHARACTERS YET TO BE SCANNED IN "USING" STRING
  CALL EVAL           ;READ A VALUE
  CALL TSTSTR         ;MAKE SURE ITS A STRING
  POP BC              ;[C]=FIELD WIDTH
  PUSH BC             ;RESAVE [B]
  PUSH HL             ;SAVE THE TEXT POINTER
  LD HL,(FACLOW)      ;GET A POINTER TO THE DESCRIPTOR
  LD B,C              ;[B]=FIELD WIDTH
  LD C,$00            ;SET UP FOR "LEFT$"
  LD A,B
  PUSH AF
  CALL __LEFT_S_1     ; into LEFT$, TRUNCATE THE STRING TO [B] CHARACTERS
  CALL PRS1           ;PRINT THE STRING
  LD HL,(FACLOW)      ;SEE IF IT NEEDS TO BE PADDED
  POP AF              ;[A]=FIELD WIDTH
  SUB (HL)            ;[A]=AMOUNT OF PADDING NEEDED
  LD B,A
  LD A,' '            ;SETUP THE PRINT CHARACTER
  INC B               ;DUMMY INCREMENT OF NUMBER OF SPACES
UPRTSP:
  DEC B               ;SEE IF MORE SPACES
  JP Z,FNSTRF         ;NO, GO SEE IF THE VALUE LIST ENDED AND RESUME SCANNING
  RST OUTDO           ;PRINT A SPACE
  JP UPRTSP           ;AND LOOP PRINTING THEM

;
; WHEN A "+" IS DETECTED IN THE "USING" STRING IF A NUMERIC FIELD FOLLOWS A BIT IN [D]
; SHOULD BE SET, OTHERWISE "+" SHOULD BE PRINTED.
; SINCE DECIDING WHETHER A NUMERIC FIELD FOLLOWS IS VERY DIFFICULT, THE BIT IS ALWAYS SET IN [D].
; AT THE POINT IT IS DECIDED A CHARACTER IS NOT PART OF A NUMERIC FIELD, THIS ROUTINE IS CALLED
; TO SEE IF THE BIT IN [D] IS SET, WHICH MEANS A PLUS PRECEDED THE CHARACTER AND SHOULD BE PRINTED.
;
PLS_PRNT:
  PUSH AF             ;SAVE THE CURRENT CHARACTER
  LD A,D              ;CHECK THE PLUS BIT
  OR A                ;SINCE IT IS THE ONLY THING THAT COULD BE TURNED ON
  LD A,'+'            ;SETUP TO PRINT THE PLUS
  CALL NZ,_OUTDO      ;PRINT IT IF THE BIT WAS SET
  POP AF              ;GET BACK THE CURRENT CHARACTER
  RET

; Vector of RST 20H (aka RST 4), OUTC.  Send A to screen or printer
;
; Output char in 'A' to console
;
;	OUTDO (either CALL or RST) prints char in [A] no registers affected
;		to either terminal or disk file or printer depending
;		flags:
;			PRTFLG if non-zero print to printer
;			PTRFIL if non-zero print to disk file pointed to by PTRFIL
;
; Used by the routines at OUTC, USING and TEL_TERM.
_OUTDO:
  PUSH AF
  PUSH HL
  CALL ISFLIO            ; Tests if I/O to device is taking place
  JP NZ,OUTC_FOUT
  POP HL
  LD A,(PRTFLG)          ;SEE IF WE WANT TO TALK TO LPT
  OR A                   ;TEST BITS
  JP Z,OUTC_LCD          ;IF ZERO THEN NOT
  POP AF                 ;GET BACK CHAR

; Print the character in the A register on the printer.  Expand tabs into
; spaces if nescessary
;
; Used by the routines at LPT_OUTPUT and TEL_TERM.
OUTC_TABEXP:
  PUSH AF
  CP $09                 ;TAB
  JP NZ,NO_TAB           ;NO
TABEXP_LOOP:
  LD A,' '
  CALL OUTC_TABEXP
  LD A,(LPTPOS)
  AND $07                ;AT TAB STOP?
  JP NZ,TABEXP_LOOP      ;GO BACK IF MORE TO PRINT
  POP AF                 ;POP OFF CHAR
  RET                    ;RETURN

NO_TAB:
  SUB $0D		; CR
  JP Z,NO_TTYIST
  JP C,NO_DOSPC
  
IF KC85 | M10
  CP $13
  JP C,NO_DOSPC
ENDIF

  LD A,(LPTPOS)
  INC A
NO_TTYIST:
  LD (LPTPOS),A
NO_DOSPC:
  POP AF
; This entry point is used by the routine at INIT_OUTPUT.
OUTC_4:
  CP $0A	; LF
  JP NZ,OUTC_5
  PUSH BC
  LD B,A
  LD A,(LPRINT_CH)
  CP $0D         ; CR
  LD A,B
  POP BC
OUTC_5:
  LD (LPRINT_CH),A
  RET Z
  CP $1A		; EOF
  RET Z
  JP LPT_OUT


; Reinitialize output, LCD and/or printer.
;
; Used by the routines at READY, _CLREG and __END.
INIT_OUTPUT:
  XOR A
  LD (PRTFLG),A
  LD A,(LPTPOS)
  OR A
  RET Z

IF M100
  LD A,(LPT_FLAG)
  OR A
  RET Z
ENDIF

; This entry point is used by the routine at __LCOPY.
INIT_OUTPUT_0:
  LD A,$0D	; CR
  CALL OUTC_4
  XOR A
  LD (LPTPOS),A
  RET


; This entry point is used by the routine at _OUTDO.
OUTC_LCD:
  POP AF

; LCD character output routine (A=char)
LCD_OUT:
  PUSH AF
  CALL OUTC_SUB0
  LD A,(CSRY)
  DEC A
  LD (TTYPOS),A
  POP AF
  RET

; Send a CRLF to screen if needed to end the current line.
;
; Used by the routines at ERESET, READY, __FILES, __CLOAD, LOAD_RECORD, __END,
; PRINT_LINE and SCHEDL_DE.
CONSOLE_CRLF:
  LD A,(CSRY)       ;GET CURRENT TTYPOS
  DEC A             ;SET CC'S
  RET Z             ;IF ALREADY ZERO, RETURN
  JP OUTDO_CRLF     ;DO CR

  LD (HL),$00
  CALL ISFLIO        ; Tests if I/O to device is taking place
  LD HL,BUFMIN
  JP NZ,CRFIN

; This entry point is used by the routines at __PRINT, __LIST and USING.
OUTDO_CRLF:
  LD A,$0D         ; CR
  RST OUTDO        ; Output char to the current device
  LD A,$0A         ; LF
  RST OUTDO        ; Output char to the current device

; This entry point is used by the routines at __PRINT and PRS1.
;DON'T PUT CR/LF OUT TO LOAD FILE
CRFIN:
  CALL ISFLIO      ;SEE IF OUTPUTTING TO DISK
  JP Z,CRCONT      ;NOT DISK FILE, CONTINUE
  XOR A            ;CRFIN MUST ALWAYS RETURN WITH A=0
  RET              ;AND CARRY=0.
  
CRCONT:
  LD A,(PRTFLG)    ;GOING TO PRINTER?
  OR A             ;TEST
  JP Z,NTPRTR      ;NO
  XOR A            ;DONE, RETURN
  LD (LPTPOS),A    ;ZERO POSITON
  RET

NTPRTR:
  XOR A            ; Set to position 0       ;SET TTYPOS=0
  LD (TTYPOS),A    ; Store it
  RET

; Routine at 19434
;
; Used by the routine at NVRFIL.
INKEY_S:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  PUSH HL               ;SAVE THE TEXT POINTER
  CALL CHSNS            ;SET NON-ZERO IF CHAR THERE
  JP Z,NULRT            ;NO, RETURN NULL STRING
  CALL CHGET
  PUSH AF
  CALL STRIN1           ;MAKE ONE CHAR STRING
  POP AF                
  LD E,A                ;CHAR TO [D]
  CALL SETSTR           ;STUFF IN DESCRIPTOR AND GOTO PUTNEW

NULRT:
  LD HL,NULL_STRING
  LD (FACLOW),HL
  LD A,$03
  LD (VALTYP),A
  POP HL
  RET

; Routine at 19467
;
; Used by the routines at OPENDO, TEL_UPLD and TXT_CTL_G.
FNAME:
  PUSH HL
  JP FNAME_1

; This entry point is used by the routines at __NAME, PRPARM, __OPEN, __MERGE
; and __SAVE.
FILE_PARMS:
  CALL EVAL
  PUSH HL
  CALL GETSTR
  LD A,(HL)
  OR A
  JP Z,_NM_ERR		; bad file name
  INC HL
  LD E,(HL)
  INC HL
  LD H,(HL)
  LD L,E			; pointer to string
  LD E,A			; size of string
FNAME_1:
  CALL PARSE_DEVNAME		; Parse Device Name, Z flag set if RAM device
  PUSH AF
  LD BC,FILNAM
  LD D,$09
  INC E
FNAME_2:
  DEC E				; end of filespecification string ?
  JP Z,FNAME_7		; yep, fill remaining FILNAME with spaces
  CALL MAKUPL
  CP ' '					; control characters ?
  JP C,_NM_ERR			; yep, bad filename error
  CP $7F		; BS
  JP Z,_NM_ERR			; bad file name
  CP '.'			; filename/extension seperator ?
  JP Z,FNAME_6		; yep, handle extension
  LD (BC),A
  INC BC
  INC HL
  DEC D
  JP NZ,FNAME_2
FNAME_3:
  POP AF
  PUSH AF
  LD D,A
  LD A,(FILNAM)
  INC A
  JP Z,_NM_ERR		; bad file name
  POP AF
  POP HL
  RET
  
_NM_ERR:
  JP NM_ERR		; NM error: bad file name
  
FNAME_5:
  INC HL
  JP FNAME_2
  
FNAME_6:
  LD A,D
  CP $09
  JP Z,_NM_ERR		; bad file name
  CP $03
  JP C,_NM_ERR		; bad file name
  JP Z,FNAME_5
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP FNAME_6
FNAME_7:
  LD A,' '
  LD (BC),A
  INC BC
  DEC D
  JP NZ,FNAME_7
  JP FNAME_3

; This entry point is used by the routine at DSKI_S.
GET_FNAME_CHAR:
  LD A,(HL)
  INC HL
  DEC E
  RET

;
; CONVERT ARGUMENT TO FILE NUMBER AND SET [B,C] TO POINT TO FILE DATA BLOCK
;
; AT THIS ENTRY POINT THE FAC HAS THE FILE NUMBER IN IT ALREADY
;
;
; Routine at 19585 ($4c81)
FILFRM:
  CALL CONINT          ;GET THE FILE NUMBER INTO [A]
;
; Comment taken from CP/M.  Things can be different here !
;
; AT THIS POINT IT IS ASSUMED THE FILE NUMBER IS IN [A]
; THE FILE NUMBER IS RETURNED IN [E]
; [D] IS SET TO ZERO. [H,L] IS SAVED.
; [B,C] IS SET TO POINT AT THE FILE DATA BLOCK FOR FILE [E]
; [A] GIVE THE MODE OF THE FILE AND ZERO IS SET, IF THE FILE IS MODE ZERO (NOT OPEN).
;
; Get information for the file number in the A register. Equal to VARPTR(#x).
;
; Used by the routines at VARPTR_BUF, SETFIL, _OPEN and CLOSE1.
; a.k.a. VARPTR_A
GETPTR:
  LD L,A                ;GET FILE NUMBER INTO [L]
  LD A,(MAXFIL)         ;IS THIS FILE # LEGAL?
  CP L                  
  JP C,BN_ERR           ;IF NOT, "BAD FILE NUMBER"  (BN error)
  LD H,$00              ;SETUP OFFSET TO GET POINTER TO FILE DATA BLOCK
  LD (RAMFILE),HL
  ADD HL,HL
  EX DE,HL
  LD HL,(FILTAB)        ;POINT AT POINTER TABLE
  ADD HL,DE             ;ADD ON OFFSET
  LD A,(HL)             ;PICK UP POINTER IN [H,L]
  INC HL
  LD H,(HL)
  LD L,A
  LD A,(HL)             ;GET MODE OF FILE INTO [A]
  OR A                  ;SET ZERO IF FILE NOT OPEN
  RET Z
  PUSH HL
  LD DE,$0004           ;(DATOFC) POINT TO DATA BLOCK
  ADD HL,DE
  LD A,(HL)
  CP $09                ; A = FILE MODE
  JP NC,FILFRM_1
  RST $38
  DEFB HC_GETP		; Offset: 30, Hook 1 for Locate FCB
  
  JP IE_ERR			; IE error: internal error

  
FILFRM_1:
  POP HL
  LD A,(HL)
  OR A
  SCF
  RET
  
;
; AT THIS ENTRY POINT [H,L] IS ASSUMED TO BE THE TEXT POINTER AND
; A FILE NUMBER IS SCANNED
;
; This entry point is used by the routine at INPUT_S.
FILSCN:
  DEC HL
  RST CHRGTB
  CP '#'             ;MAKE NUMBER SIGN OPTIONAL
  CALL Z,__CHRGTB    ;BY SKIPPING IT IF THERE
  CALL GETINT        ;READ THE FILE NUMBER INTO THE FAC
  EX (SP),HL
  PUSH HL

; Routine at 19647
;
; a.k.a. SELECT. This entry point is used by the routines at _LOAD, __MERGE and FILINP.
SETFIL:
  CALL GETPTR
  JP Z,CF_ERR
  LD (PTRFIL),HL			; Redirect I/O
  RST $38
  DEFB HC_SETF		; Offset: 12
  RET

; Routine at 19659
__OPEN:
  LD BC,FINPRT
  PUSH BC
  CALL FILE_PARMS
  JP NZ,__OPEN_0
  LD D,RAM_DEVTYPE		; D = 'RAM' device ?
  
__OPEN_0:
  RST SYNCHR
  DEFB TK_FOR
  CP $84				; TK_INPUT, 'INPUT' TOKEN code
  LD E,$01
  JP Z,__OPEN_INPUT
  
  CP $96			; TK_OUT ('OUT..P.U.T' !)
  JP Z,__OPEN_OUTPUT
  
  RST SYNCHR
  DEFB 'A'
  RST SYNCHR
  DEFB 'P'
  RST SYNCHR
  DEFB 'P'
  RST SYNCHR
  ADD A,B			; DEFB TK_END
  LD E,$08			; 'APPEND'
  JP __OPEN_2
  
__OPEN_OUTPUT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR
  DEFB 'P'
  RST SYNCHR
  DEFB 'U'
  RST SYNCHR
  DEFB 'T'		; "OUTPUT"  :S
  LD E,$02

  DEFB $3E  ; "LD A,n" to Mask the next byte

__OPEN_INPUT:
  RST CHRGTB		; Gets next character (or token) from BASIC text.		; Gets next character (or token) from BASIC text.
__OPEN_2:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB 'A'
  RST SYNCHR
  DEFB 'S'			; 'AS'
  PUSH DE
  LD A,(HL)
  CP '#'             ;MAKE NUMBER SIGN OPTIONAL
  CALL Z,__CHRGTB    ;BY SKIPPING IT IF THERE
  CALL GETINT        ;READ THE FILE NUMBER INTO THE FAC
  OR A
  JP Z,BN_ERR			; BN error: bad file nuber
  RST $38
  DEFB HC_NOFO		; Offset: 24

;L4D11:
;  LD E,$D5
  
  DEFB $1E      ;LD E,N

; Routine at 19730
;
; Used by the routines at __MERGE, __SAVE, __EDIT, TXT_CTL_G and TXT_CTL_V.
; File must be specified in FILNAM, A=open mode(1=input, 2=output, $10=append)
_OPEN:
  PUSH DE
  DEC HL
  LD E,A
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP NZ,SN_ERR
  EX (SP),HL
  LD A,E
  PUSH AF
  PUSH HL
  CALL GETPTR
  JP NZ,AO_ERR
  POP DE
  LD A,D
  CP $09
  RST $38
  DEFB HC_NULO		; Offset: 28
  
  JP C,IE_ERR			; IE error: internal error
  PUSH HL
  LD BC,$0004
; This entry point is used by the routine at __OPEN.
_OPEN_0:
  ADD HL,BC
  LD (HL),D
  LD A,$00
  POP HL
  JP GET_DEVICE

; Routine at 19768
;
; Used by the routines at __CLOSE, INIT_PRINT_h and L4F2E.
CLOSE1:
  PUSH HL
  OR A
  JP NZ,NTFL0
  LD A,(NLONLY)			; <>0 when loading program
  AND $01
  JP NZ,POPHLRT2      ;   POP HL / RET

; NTFL0 - "NoT FiLe number 0"
NTFL0:
  CALL GETPTR
  JP Z,_CLOSE_0
  
  LD (PTRFIL),HL			; Redirect I/O
  PUSH HL
  LD A,$02
  JP C,GET_DEVICE

  RST $38
  DEFB HC_NTFL		; Offset: 20
  JP IE_ERR			; IE error: internal error

; LCD, CRT, and LPT file close routine
;
; Used by the routines at RAM_CLS, CAS_CLS and COM_CLS.
_CLOSE:
  CALL INPUT_S_6
  POP HL
; This entry point is used by the routine at CLOSE1.
_CLOSE_0:
  PUSH HL
  LD DE,$0007
  ADD HL,DE
  LD (HL),A
  LD H,A
  LD L,A
  LD (PTRFIL),HL			; Redirect I/O
  POP HL
  ADD A,(HL)
  LD (HL),$00
  POP HL
  RET

; RUN statement with text following the RUN
;
; Used by the routine at __RUN.
_RUN_FILE:
  SCF
  defb $11	; LD DE,NN

; Routine at 19824
__LOAD:
  defb $f6		; OR $AF

; Routine at 19825
__MERGE:
  XOR A
  PUSH AF
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CP 'M'
  JP Z,LOADM_RUNM
  CALL FILE_PARMS
  JP Z,MERGE_SUB
  LD A,D
  CP RAM_DEVTYPE	; D = 'RAM' device ?
  JP Z,MERGE_SUB
  CP CAS_DEVTYPE	; D = 'CAS' device ?
  JP Z,__CLOAD_0
  RST $38
  DEFB HC_MERG		; Offset: 26
  
; This entry point is used by the routine at __LCOPY.
__MERGE_0:
  POP AF
  PUSH AF
  JP Z,__MERGE_2
  LD A,(HL)
  SUB ','
  OR A
  JP NZ,__MERGE_2
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  RST SYNCHR
  DEFB 'R'
  POP AF
  SCF
; This entry point is used by the routine at __EDIT.
__MERGE_1:
  PUSH AF
__MERGE_2:
  PUSH AF
  XOR A
  LD E,$01
  CALL _OPEN

; This entry point is used by the routine at LOAD_RECORD.
__MERGE_3:
  LD HL,(PTRFIL)
  LD BC,$0007
  ADD HL,BC
  POP AF
  SBC A,A
  AND $80
  OR $01
  LD (NLONLY),A
  POP AF
  PUSH AF
  SBC A,A
  LD (FILFLG),A
  LD A,(HL)
  OR A
  JP M,__SAVE_3
  POP AF
  CALL NZ,CLRPTR
  CALL CLSALL		; Close all files
  XOR A
  CALL SETFIL
  JP PROMPT

; Routine at 19919
__SAVE:
  CP 'M'
  JP Z,SAVEM
  CALL _CLVAR
  CALL FILE_PARMS
  JP Z,__LCOPY_6
  LD A,D
  CP RAM_DEVTYPE	; D = 'RAM' device ?
  JP Z,__LCOPY_6
  CP CAS_DEVTYPE	; D = 'CAS' device ?
  JP Z,__CSAVE_0
  RST $38
  DEFB HC_SAVE		; Offset: 22
  
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.  
  LD E,$80
  SCF
  JP Z,__SAVE_0
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  RST SYNCHR
  DEFB 'A'
  OR A
  LD E,$02
__SAVE_0:
  PUSH AF
  LD A,D
  CP $09
  JP C,__SAVE_1
  LD A,E
  AND $80
  JP Z,__SAVE_1
  LD E,$02
  POP AF
  XOR A
  PUSH AF
  
; This entry point is used by the routines at __LCOPY and __CSAVE.
__SAVE_1:
  XOR A
  CALL _OPEN
  POP AF
  JP C,__SAVE_2
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __LIST
  
__SAVE_2:
  RST $38
  DEFB HC_BINS		; Offset: 34, Hook 2 for "SAVE"
  JP NM_ERR
  
; This entry point is used by the routine at __MERGE.
__SAVE_3:
  RST $38
  DEFB HC_BINL 		; Offset: 36, Hook for "MERGE/LOAD"
  JP NM_ERR
  
; This entry point is used by the routines at __KILL, _CLREG, __END, __MERGE
; and __MAX.
; Close all files
CLSALL:
  LD A,(NLONLY)
  OR A
; This entry point is used by the routine at __CLOSE.
__SAVE_5:
  RET M

; Routine at 20007
CLOSE_FN:
  XOR A

; Routine at 20008
__CLOSE:
  LD A,(MAXFIL)
  JP NZ,__CLOSE_1
  PUSH HL
__CLOSE_0:
  PUSH AF

IF M100
  OR A
ENDIF

  CALL CLOSE1
  POP AF
  DEC A
  JP P,__CLOSE_0
  POP HL
  RET
  
__CLOSE_1:
  LD A,(HL)
  CP '#'                ;MAKE NUMBER SIGN OPTIONAL
  CALL Z,__CHRGTB       ;BY SKIPPING IT IF THERE
  CALL GETINT           ;READ THE FILE NUMBER INTO THE FAC
  PUSH HL
IF M100
  SCF
ENDIF
  CALL CLOSE1
  POP HL
  LD A,(HL)
  CP ','
  RET NZ
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP __CLOSE_1
  
; This entry point is used by the routine at _OUTDO.
OUTC_FOUT:
  POP HL
  POP AF
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,(PTRFIL)
  LD A,$04
  CALL OUTC_FOUT_0
  RST $38
  DEFB HC_FILOU 		; Offset: 32
  JP NM_ERR
  
; This entry point is used by the routines at RDBYT and L4F2E.
OUTC_FOUT_0:
  PUSH AF
  PUSH DE
  EX DE,HL
  LD HL,$0004
  ADD HL,DE
  LD A,(HL)
  EX DE,HL
  POP DE
  CP $09
  JP C,INIT_PRINT_h_1
  POP AF
  EX (SP),HL
  POP HL
  JP GET_DEVICE

; Routine at 20090
;
; Used by the routines at INXD, INPUT_S, L4F2E and TXT_CTL_V.
RDBYT:
  PUSH BC
  PUSH HL
  PUSH DE
  LD HL,(PTRFIL)
  LD A,$06
  CALL OUTC_FOUT_0
  RST $38
  DEFB HC_INDSKC
  JP NM_ERR

; This entry point is used by the routines at RAM_INPUT, CAS_INPUT, COM_INPUT and
; __EOF.
RDBYT_0:
  POP DE
  POP HL
  POP BC
  RET

; INPUT$ Function
;
; Used by the routine at NVRFIL.
INPUT_S:
  RST CHRGTB		; Gets next character (or token) from BASIC text.		; Gets next character (or token) from BASIC text.
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '$'
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB '('
  PUSH HL
  LD HL,(PTRFIL)
  PUSH HL
  LD HL,$0000
  LD (PTRFIL),HL			; Redirect I/O
  POP HL
  EX (SP),HL
  CALL GETINT                 ; Get integer 0-255
  PUSH DE
  LD A,(HL)
  CP ','
  JP NZ,INPUT_S_1
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL FILSCN
  CP $01

IF M100
  JP Z,INPUT_S_0
  CP $04
ENDIF

  JP NZ,EF_ERR		; End of file error ("Input past END")
INPUT_S_0:
  POP HL
  XOR A
  LD A,(HL)
INPUT_S_1:
  PUSH AF
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ')'
  POP AF
  EX (SP),HL
  PUSH AF
  LD A,L
  OR A
  JP Z,FC_ERR
  PUSH HL
  CALL MKTMST			; Make temporary string
  EX DE,HL
  POP BC
INPUT_S_2:
  POP AF
  PUSH AF
  JP Z,INPUT_S_5
  CALL CHGET
  CP $03		; CTL_C ?
  JP Z,INPUT_S_4
INPUT_S_3:
  LD (HL),A
  INC HL
  DEC C
  JP NZ,INPUT_S_2
  POP AF
  POP BC
  POP HL
  RST $38
  DEFB HC_RSLF		; Offset: 16
  
  LD (PTRFIL),HL			; Redirect I/O
  PUSH BC
  JP TSTOPL

INPUT_S_4:
  POP AF
  LD HL,(CURLIN)
  LD (ERRLIN),HL
  POP HL
  JP BASIC_MAIN
INPUT_S_5:
  CALL RDBYT
  JP C,EF_ERR
  JP INPUT_S_3

; This entry point is used by the routine at _CLOSE.
INPUT_S_6:
  CALL INIT_PRINT_h_0
  PUSH HL
  LD B,$00
  CALL ZERO_MEM
; This entry point is used by the routine at CLOSE1.
POPHLRT2:
  POP HL
  RET

; Zero the memory starting at HL for B number of bytes
;
; Used by the routines at INPUT_S, INITIO and POPALL_INT.
ZERO_MEM:
  XOR A

; Fill the memory starting at HL with the byte in the A register for B number
; of bytes
INIT_PRINT_h:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,INIT_PRINT_h
  RET
; This entry point is used by the routine at INPUT_S.
INIT_PRINT_h_0:
  LD HL,(PTRFIL)
  LD DE,$0009
  ADD HL,DE
  RET
  
; This entry point is used by the routine at __CLOSE.
INIT_PRINT_h_1:
  POP AF
  RET
  
; This entry point is used by the routine at PROMPT.
EXEC_FILE:
  CALL ISFLIO        ; Tests if I/O to device is taking place
  JP Z,EXEC
  XOR A
  CALL CLOSE1
  JP DS_ERR

; FILINP AND FILGET -- SCAN A FILE NUMBER AND SETUP PTRFIL

; REVISION HISTORY
; 4/23/78   PGA - ALLOW # ON CLOSE
; 8/6/79    PGA - IF ^C ON MBASIC FOO, DONT RETURN TO SYSTEM. SEE 'NOTINI'
; 6/27/80   PGA - FIX INPUT#1,D# SO IT USES FINDBL INSTEAD OF FIN AND THUS AVOIDS LOSING SIGNIFICANCE.

; Get stream number (default #channel=1)
; This entry point is used by the routines at FILSTI and L4F2E.
FILINP:
  LD C,$01          ; (MD.SQI) MUST BE SEQUENTIAL INPUT

; Get stream number (C=default #channel)
; Look for '#' channel specifier and put the associated file buffer in BC
; This entry point is used by the routine at __PRINT.
FILGET:
  CP '#'            ;NUMBER SIGN THERE?
  RET NZ            ;NO, NOT DISK READER

; Routine called by the PRINT statement to initialize a PRINT #: Get stream
; number (C=default #channel)
L4F2E:
  PUSH BC           ;SAVE EXPECTED MODE
  CALL FNDNUM		; Numeric argument (0..255)
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','          ;GO PAST THE COMMA
  LD A,E
  PUSH HL
  CALL SETFIL       ;SETUP PTRFIL = HL
  LD A,(HL)
  POP HL
  POP BC            ;[C]=FILE MODE
  CP C              ;IS IT RIGHT?
  JP Z,GDFILM       ;GOOD FILE MODE
  JP BN_ERR			; BN error: bad file nuber
  
GDFILM:
  LD A,(HL)
  RET
  
; This entry point is used by the routines at READY, INXD, __EDIT, TXT_CTL_Y,
; TXT_CTL_G and TXT_CTL_V.
CLOSE_STREAM:
  LD BC,STKERR_0
  PUSH BC
  XOR A
  JP CLOSE1

; This entry point is used by the routine at __READ.
FILIND:
  RST GETYPR             ;SEE IF INPUT IS STRING OR NUMBER
  LD BC,DOASIG           ;RETURN ADDRESS TO SETUP [FAC]
  LD DE,$2C20            ; D=','  E=' '   ..SETUP TERMINATORS SPACE AND COMMA
  JP NZ,INPDOR           ;IF NUMERIC, GO READ THE FILE
  LD E,D                 ;MAKE BOTH TERMINATORS COMMA
  JP INPDOR              ;GO READ THE FILE

; LINE INPUT & READ CODE FOR ITEM FETCHING FROM SEQUENTIAL INPUT FILES
; This entry point is used by the routine at __LINE.
LINE_INPUT:
  LD BC,FINPRT           ;RESET TO CONSOLE WHEN DONE READING
  PUSH BC                ;SAVE ON STACK
  CALL FILINP            ;GET FILE NUMBER SET UP
  CALL GETVAR            ;READ STRING TO STORE INTO
  CALL TSTSTR            ;MAKE SURE IT WAS A STRING
  PUSH DE
  LD BC,LETCON		; $09C4 on KC85, GOOD RETURN ADDRESS FOR ASSIGNMENT
  XOR A                  ;SET A=0 FOR STRING VALUE TYPE
  LD D,A                 ;ZERO OUT BOTH TERMINATORS
  LD E,A
INPDOR:
  PUSH AF                ;SAVE VALUE TYPE
  PUSH BC                ;SAVE RETURN ADDRESS
  PUSH HL                ;SAVE POINTER AT DATA COMING IN A DUMMY POINTER AT BUFMIN
NOTNWT:
  CALL RDBYT             ;READ A CHARACTER
  JP C,EF_ERR            ;READ PAST END ERROR IF EOF  - "Input past END" (EOF)
  CP ' '                 ;SKIP LEADING SPACES
  JP NZ,NOTSPC           ;EXCEPT FOR LINE INPUT
  INC D                  ;CHECK FOR LINEINPUT
  DEC D
  JP NZ,NOTNWT           ;SKIP ANY NUMBER
NOTSPC:
  CP '"'                 ;QUOTED STRING COMING IN?
  JP NZ,NOTQTE           
  LD A,E                 ;SAVE THE QUOTE
  CP ','                 ;MUST BE INPUT OF A STRING
  LD A,'"'               ;WHICH HAS [E]=44
  JP NZ,NOTQTE           ;QUOTE BACK INTO [A]
  LD D,A                 
  LD E,A                 ;TERMINATORS ARE QUOTES ONLY
  CALL RDBYT             
  JP C,QUITSI            ;READ PAST QUOTATION
NOTQTE:                  ;IF EOF, ALL DONE
  LD HL,KBUF             ;BUFFER FOR DATA
  LD B,$FF               ;MAXIMUM NUMBER OF CHARACTERS (255)
LOPCRS:
  LD C,A                 ;SAVE CHARACTER IN [C]
  LD A,D                 ;CHECK FOR QUOTED STRING
  CP '"'                 
  LD A,C                 ;RESTORE CHARACTER
  JP Z,NOTQTL            ;DON'T IGNORE CR OR STOP ON LF
  CP $0D                 ;CR?
  PUSH HL                ;SAVE DEST PTR. ON STACK
  JP Z,ICASLF            ;EAT LINE FEED IF ONE
  POP HL                 ;RESTORE DEST. PTR.
  CP $0A                 ;LF?
  JP NZ,NOTQTL           ;NO, TEST OTHER TERMINATORS
SKIP_LF:
  LD C,A                 ;SAVE CURRENT CHAR
  LD A,E                 ;GET TERMINATOR 2
  CP ','                 ;CHECK FOR COMMA (UNQUOTED STRING)
  LD A,C                 ;RESTORE ORIG CHAR
  CALL NZ,STRCHR         ;IF NOT, STORE LF (?)
  CALL RDBYT             ;GET NEXT CHAR
  JP C,QUITSI            ;IF EOF, ALL DONE.
  CP $0A                 ;IS IT LF?
  JP Z,SKIP_LF
  CP $0D                 ;IS IT A CR?
  JP NZ,NOTQTL           ;IF NOT SEE IF STORE NORMALLY
  LD A,E                 ;GET TERMINATOR
  CP ' '                 ;IS IT NUMERIC INPUT?
  JP Z,LPCRGT            ;IF SO, IGNORE CR, DONT PUT IN BUFFER
  CP ','                 ;IS IT NON-QUOTED STRING (TERM=,)
  LD A,$0D               ;GET BACK CR.
  JP Z,LPCRGT            ;IF SO, IGNORE CR.
NOTQTL:
  OR A                   ;IS CHAR ZERO
  JP Z,LPCRGT            ;ALWAYS IGNORE, AS IT IS TERMINATOR FOR STRLIT (SEE QUIT2B)
  CP D                   ;TERMINATOR ONE?
  JP Z,QUITSI            ;STOP THEN
  CP E                   ;TERMINATOR TWO?
  JP Z,QUITSI            
  CALL STRCHR            ;SAVE THE CHAR
LPCRGT:
  CALL RDBYT
  JP NC,LOPCRS
QUITSI:
  PUSH HL                ;SAVE PLACE TO STUFF ZERO
  CP '"'                 ;STOPPED ON QUOTE?
  JP Z,MORSPC            ;DON'T SKIP SPACES THEN, BUT DO SKIP FOLLOWING COMMA OR CRLF THOUGH
  CP ' '                 ;STOPPED ON SPACE?
  JP NZ,NOSKCR           ;NO, DON'T SKIP SPACES OR ANY FOLLOWING COMMAS OR CRLFS EITHER
MORSPC:
  CALL RDBYT             ;READ SPACES
  JP C,NOSKCR            ;EOF, ALL DONE.
  CP ' '
  JP Z,MORSPC
  CP ','                 ;COMMA?
  JP Z,NOSKCR            ;OK, SKIP IT
  CP $0D                 ;CARRIAGE RETURN?
  JP NZ,BAKUPT           ;BACK UP PAST THIS CHARACTER
ICASLF:
  CALL RDBYT             ;READ ANOTHER
  JP C,NOSKCR            ;EOF, ALL DONE.
  CP $0A                 ;LINE FEED?
  JP Z,NOSKCR            ;OK, SKIP IT TOO
BAKUPT:
  LD HL,(PTRFIL)
  LD C,A
  LD A,$08
  CALL OUTC_FOUT_0
  RST $38
  DEFB HC_BAKU		; Offset: 18
  JP NM_ERR

; This entry point is used by the routine at COM_UNGETC.
NOSKCR:
  POP HL                 ;GET BACK PLACE TO STORE TERMINATOR
QUIT2B:
  LD (HL),$00            ;STORE THE TERMINATOR
  LD HL,BUFMIN           ;(buf-1) ITEM IS NOW STORED AT THIS POINT +1
  LD A,E                 ;WAS IT A NUMERIC INPUT?
  SUB $20                ;IF SO, [E]=" "
  JP Z,NUMIMK            ;USE FIN TO SCAN IT
  LD B,$00
  CALL QTSTR_0
  POP HL                 ;GET BACK [H,L]
  RET                    ;DO ASSIGNMENT

NUMIMK:
  RST GETYPR             ;GET TYPE OF NUMERIC VARIABLE BEING READ
  PUSH AF                ;SAVE IT
  RST CHRGTB             ;READ FIRST CHARACTER
  POP AF                 ;RESTORE TYPE OF VARIABLE
  PUSH AF                ;SAVE BACK
  CALL C,FIN_DBL         ;SINGLE PRECISION INPUT
  POP AF                 ;GET BACK TYPE OF VAR
  CALL NC,FIN_DBL        ;DOUBLE PRECISION INPUT
  POP HL                 ;GET [H,L]
  RET                    ;DO THE ASSIGNMENT

STRCHR:
  OR A                   ;TRYING TO STORE NULL BYTE
  RET Z                  ;RETURN, DONT STORE IT
  LD (HL),A              ;STORE THE CHARACTER
  INC HL
  DEC B                  ;128 YET?
  RET NZ                 ;MORE SPACE IN BUFFER, RETURN
  POP AF                 ;GET RID OF SUPERFLUOUS STACK ENTRY
  JP QUIT2B              ;SPECIAL QUIT

; NM error: bad file name
;
; Used by the routines at LCDLPT_OPN, CAS_OPN, COM_OPN, __EOF, __LCOPY, FINDCO,
; FNAME, __SAVE, L4F2E and DSKI_S.
NM_ERR:
  LD E,$37
  
  defb $01	; LD BC,NN

; AO error: file already open
;
; Used by the routines at RAM_OPN and _OPEN.
AO_ERR:
  LD E,$35
  
  defb $01	; LD BC,NN

; DS error: direct statement in a program being loaded
;
; Used by the routine at INIT_PRINT_h.
DS_ERR:
  LD E,$38
  
  defb $01	; LD BC,NN

; FF error: file not found
;
; Used by the routines at RAM_OPN, __KILL, __NAME and CLOADM.
FF_ERR:
  LD E,$34
  
  defb $01	; LD BC,NN

; CF error: file not open
;
; Used by the routines at __EOF and SETFIL.
CF_ERR:
  LD E,$3A
  
  defb $01	; LD BC,NN

; BN error: bad file nuber
;
; Used by the routines at GETPTR, __OPEN and L4F2E.
BN_ERR:
  LD E,$33
  
  defb $01	; LD BC,NN

; IE error: internal error
;
; Used by the routines at _OPEN and CLOSE1.
IE_ERR:
  LD E,$32
  
  defb $01	; LD BC,NN

; EF error: end of file
;
; Used by the routines at INPUT_S and L4F2E.
EF_ERR:
  LD E,$36
  
  defb $01	; LD BC,NN

; FL error: too many files
;
; Used by the routine at NXTDIR.
FL_ERR:
  LD E,$39
  JP ERROR


; LOF Function
__LOF:
  RST $38
  DEFB HC_LOF		; Offset: 78


; LOC Function
__LOC:
  RST $38
  DEFB HC_LOC		; Offset: 80


; __LFILES
__LFILES:
  RST $38
  DEFB HC_FILE		; Offset: 82


; DSKO$
__DSKO_S:
  RST $38
  DEFB HC_DSKO		; Offset: 86


; DSKI$
; Used by the routine at NVRFIL.
DSKI_S:
  RST $38
  DEFB HC_DSKI		; Offset: 84


; Routine at 20597
; Used by the routine at FNAME.
; Parse Device Name, Z flag set if RAM device
PARSE_DEVNAME:
  RST $38
  DEFB HC_PARD		; Offset: 40, Hook 1 for "Parse device name" event

  LD A,(HL)
  CP ':'
  JP C,POSDSK
  PUSH HL
  LD D,E
  CALL GET_FNAME_CHAR
  JP Z,L5077_1
L5077_0:
  CP ':'
  JP Z,GET_DEVNAME
  CALL GET_FNAME_CHAR
  JP P,L5077_0
L5077_1:
  LD E,D
  POP HL
  XOR A
  RST $38
  DEFB HC_NODE		; Offset: 42, Hook 2 for "Parse device name" event
  RET
  
; Routine at 20630
;
; Used by the routine at L5077.
POSDSK:
  RST $38
  DEFB HC_POSD		; Offset: 46
  JP NM_ERR		; NM error: bad file name

GET_DEVNAME:
  LD A,D
  SUB E
  DEC A
  CP $02		; Continue only if dev name length >= 2
  JP NC,MAP_DEVNAME
  RST $38
  DEFB HC_DEVNAM		; Offset: 44  
  JP NM_ERR		; NM error: bad file name

MAP_DEVNAME:
  CP $05		; Error if dev name length > 4
  JP NC,NM_ERR	; NM error: bad file name
  POP BC
  PUSH DE
  PUSH BC
  LD C,A		; dev name length
  LD B,A
  LD DE,DEVICE_TBL
  EX (SP),HL
  PUSH HL
DEVN_LOOP:
  CALL MAKUPL
  PUSH BC
  LD B,A
  LD A,(DE)
  INC HL
  INC DE
  CP B
  POP BC
  JP NZ,DSKI_S_8
  DEC C
  JP NZ,DEVN_LOOP

DSKI_S_6:
  LD A,(DE)
  OR A
  JP M,DSKI_S_7
  CP '1'
  JP NZ,DSKI_S_8
  INC DE
  LD A,(DE)
  JP DSKI_S_8
  
DSKI_S_7:
  POP HL
  POP HL
  POP DE
  OR A
  RET
  
DSKI_S_8:
  OR A
  JP M,DSKI_S_6
DSKI_S_9:
  LD A,(DE)
  OR A
  INC DE
  JP P,DSKI_S_9
  LD C,B
  POP HL
  PUSH HL
  LD A,(DE)
  OR A
  JP NZ,DEVN_LOOP
  JP NM_ERR				; NM error: bad file name
  
DEVICE_TBL:
  DEFM "LCD"              ; Start of device name table.  Each name ends with a
  DEFB LCD_DEVTYPE
  DEFM "CRT"
  DEFB CRT_DEVTYPE
  DEFM "CAS"
  DEFB CAS_DEVTYPE
  DEFM "COM"
  DEFB COM_DEVTYPE
  DEFM "WAND"
  DEFB WAND_DEVTYPE
  DEFM "LPT"
  DEFB LPT_DEVTYPE
IF M100
  DEFM "MDM"
  DEFB MDM_DEVTYPE
ENDIF
  DEFM "RAM"
  DEFB RAM_DEVTYPE
  NOP


; Start of device control block vector addresses (jp table)
DEVICE_VECT:
  DEFW LCD_CTL
  DEFW CRT_CTL
  DEFW CAS_CTL
  DEFW COM_CTL
  DEFW WAND_CTL
  DEFW LPT_CTL
IF M100
  DEFW MDM_CTL
ENDIF
  DEFW RAM_CTL


; Routine at 20771
;
; Used by the routines at __EOF, _OPEN, CLOSE1 and __CLOSE.
GET_DEVICE:
  RST $38
  DEFB HC_GEND		; Offset: 48
  
  PUSH HL
  PUSH DE
  PUSH AF
  LD DE,$0004
  ADD HL,DE
  LD A,$FF
  SUB (HL)
  ADD A,A
  LD E,A
  LD D,$00
  LD HL,DEVICE_VECT
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  POP AF
  LD L,A
  LD H,$00
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  POP DE
  EX (SP),HL
  RET


; Entry to TELCOM
;
; Used by the routine at TEL_BYE.
TELCOM:

IF KC85 | M10
  RST $38
  DEFB HC_TRMEND
ENDIF

  CALL UNLOCK
  LD HL,TELCOM_BAR
  CALL STDSPF
  JP TEL_GET_STAT

; This entry point is used by the routines at TELCOM_RDY, TEL_SET_STAT,
; TEL_CALL and TEL_FIND.
TELCOM_MAIN:
IF KC85 | M10
  RST $38
  DEFB HC_SD232C
ENDIF
  CALL __BEEP
  LD HL,TELCOM_BAR
  CALL STFNK

; TELCOM Ready re-entry point for TELCOM commands
;
; Used by the routines at TEL_GET_STAT, TEL_SET_STAT, TEL_CALL and TEL_FIND.
TELCOM_RDY:
  CALL STKINI
  LD HL,TELCOM_MAIN
  LD (ERRTRP),HL
  LD HL,TELCOM_PROMPT
  CALL PRINT_LINE
  CALL _INLIN		; Line input, FN keys are supported.
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  JP Z,TELCOM_RDY
  
IF M100
  LD DE,TELCOM_TBL
ENDIF

IF KC85 | M10
  EX DE,HL
  LD HL,(TELCOM_TBL_PIVOT)
  EX DE,HL
ENDIF

  CALL PARSE_COMMAND
  JP Z,TELCOM_MAIN
  RET


TELCOM_PROMPT:
  DEFM "Telcom: "
  DEFB $00


; Start of TELCOM instruction table.  Each entry starts with a 4 byte
; instruction name followed by a 2 byte routine addr-

TELCOM_TBL:

  DEFM "STAT"
  DEFW TEL_STAT
  
  DEFM "TERM"
  DEFW TEL_TERM

IF M100
  DEFM "CALL"
  DEFW TEL_CALL

  DEFM "FIND"
  DEFW TEL_FIND
ENDIF

  DEFM "MENU"
L51A1:
  DEFW __MENU

L51A3:
  DEFB $FF
  
TELCOM_BAR:

IF KC85 | M10
  DEFB $80
  DEFB $80
ENDIF

IF M100
  DEFM "Find"
  DEFB ' '+$80
  DEFM "Call"
  DEFB ' '+$80
ENDIF

  DEFM "Stat"
  DEFB ' '+$80
  DEFM "Term"
  DEFB CR+$80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFM "Menu"
  DEFB CR+$80

; TELCOM STAT instruction routine
TEL_STAT:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.

IF KC85 | M10
  AND	A
ENDIF

IF M100
  INC A
  DEC A
ENDIF

  JP NZ,TEL_SET_STAT

; Print current STAT (RS232 settings for TELCOM) and return to TELCOM'
;
; Used by the routine at TELCOM.
TEL_GET_STAT:
  LD HL,STAT
  LD B,$05
TEL_GET_STAT_0:
  LD A,(HL)
  RST OUTDO
  INC HL
  DEC B
  JP NZ,TEL_GET_STAT_0

IF M100
  LD A,','
  RST OUTDO
  LD A,(DIAL_SPEED)
  RRCA		; convert speed to digit for status bar display
  LD A,$32
  SBC A,B
  RST OUTDO
  LD HL,PULSES_MSG
  CALL PRS
ENDIF

  JP TELCOM_RDY


IF M100
; Message at 20967
PULSES_MSG:
  DEFM "0 pps"
  DEFB $00
ENDIF

; Set STAT (RS232 settings for TELCOM) and return to TELCOM
;
; Used by the routine at TEL_STAT.
TEL_SET_STAT:
IF M100
  JP C,TEL_SET_STAT_0
  CP ','
  JP Z,TEL_SET_STAT_1
  CALL UCASE
  CP $4D		; 'M', Modem
  JP NZ,TELCOM_MAIN
  INC HL
TEL_SET_STAT_0:
ENDIF

  CALL SETSER		;   HL = zero terminated setup string, e.g. "78E1E"
  CALL CLSCOM

IF M100
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  JP Z,TELCOM_RDY
TEL_SET_STAT_1:
  RST SYNCHR 		;   Check syntax: next byte holds the byte to be found
  DEFB ','
  CALL GETINT                 ; Get integer 0-255
  CP $14
  JP Z,TEL_SET_STAT_2
  SUB $0A
  JP NZ,TELCOM_MAIN
  INC A
TEL_SET_STAT_2:
  LD (DIAL_SPEED),A
ENDIF

  JP TELCOM_RDY
 

IF M100

; This entry point is used by the routine at TEL_FIND.
TEL_SET_STAT_3:
  LD HL,CALMSG
  CALL PRINT_TEXT
  POP DE
  CALL TEL_FIND_1
  JP Z,TELCOM_MAIN
  EX DE,HL
  defb $f6  ; OR $37

; TELCOM CALL instruction routine
TEL_CALL:
  SCF
  PUSH HL
  LD HL,CALMSG
  CALL C,PRINT_TEXT
  POP HL
  CALL TEL_LOGON
  JP C,TELCOM_MAIN
  JP NZ,TELCOM_RDY
  JP TEL_TERM_0

; Text at 21060
CALMSG:
  DEFM "Calling "
  DEFB $00

; TELCOM FIND instruction routine
;
; Used by the routine at CALMSG.
TEL_FIND:
  SUB A
  CALL SHOW_TIME_3
  PUSH HL
  CALL FNDFLO		; Look for "ADDRS.DO"
  JP Z,TELCOM_MAIN
  CALL GTXTTB
  EX DE,HL
  POP HL
TEL_FIND_0:
  CALL FIND_TEXT
  JP NC,TELCOM_RDY
  PUSH HL
  PUSH DE
  CALL NO_TEXTMODE
  CALL TEL_FIND_1
  CALL NZ,TEL_FIND_2
  CALL TXT_CRLF
  CALL FIND_OPTIONS
  JP Z,TELCOM_RDY
  CP $43	; 'C'
  JP Z,TEL_SET_STAT_3
  POP DE
  CALL NEXT_CRLF
  POP HL
  JP TEL_FIND_0
; This entry point is used by the routine at TEL_SET_STAT.
TEL_FIND_1:
  CALL TEL_FIND_4
  RET Z
  RST OUTDO
  CP ':'
  INC DE
  JP NZ,TEL_FIND_1
  JP TEL_FIND_5
TEL_FIND_2:
  CALL TEL_FIND_4
  RET Z
  CP '<'
  JP Z,TEL_FIND_3
  CP ':'
  RET Z
  RST OUTDO
  INC DE
  JP TEL_FIND_2
TEL_FIND_3:
  RST OUTDO
  LD A,'>'
  RST OUTDO
  RET

TEL_FIND_4:
  CALL IS_CRLF
  DEC DE
  LD A,(DE)
  RET Z
TEL_FIND_5:
  CP $1A		; EOF
  JP Z,TELCOM_MAIN
  RET



; This entry point is used by the routines at TEL_CONN, TEL_LIFT and
; TEL_DIAL_DGT.
TEL_LIFT_ON:
  IN A,($BA)
  AND $7F
  OUT ($BA),A
  RET

; Disconect phone line and disable modem carrier
;
; Used by the routines at COM_OPN, MDM_CLS, TEL_LOGON and TEL_BYE.
TEL_DISC:
  CALL TEL_CONN_0
  CALL TEL_LOGON_0
; This entry point is used by the routines at TEL_LOGON and TEL_DIAL_DGT.
TEL_LIFT_OFF:
  IN A,($BA)
  OR $80
  OUT ($BA),A
  RET

; This entry point is used by the routines at TEL_LIFT and TEL_LOGON.
TEL_DISC_1:
  LD A,(PORT_A8)
  OR $01
  JP TEL_CONN_1

; Connect phone line and enable modem carrier
;
; Used by the routines at TEL_LIFT and TEL_LOGON.
TEL_CONN:
  CALL TEL_LIFT_ON
  LD A,$03
  JP TEL_CONN_1
; This entry point is used by the routines at TEL_DISC and TEL_LOGON.
TEL_CONN_0:
  LD A,(PORT_A8)
  AND $01
; This entry point is used by the routines at TEL_DISC and TEL_LOGON.
TEL_CONN_1:
  LD (PORT_A8),A
  OUT ($A8),A
  SCF
  RET

; Lift telephone and wait for a carrier.
;
; Used by the routines at COM_OPN, TEL_LOGON and TEL_TERM.
TEL_LIFT:
  IN A,($BB)
  AND $10
  JP Z,TEL_LIFT_1
  CALL TEL_CONN
TEL_LIFT_0:
  CALL BREAK
  RET C
  CALL CARDET
  JP NZ,TEL_LIFT_0
  RET

TEL_LIFT_1:
  CALL TEL_DISC_1
  CALL TEL_LIFT_ON
  NOP
  NOP
  NOP
  CALL TEL_LIFT_0
  RET C
  LD A,$05
  CALL TMDELA
  CALL TEL_CONN
  AND A
  RET

; Pause for about 2 seconds
;
; Used by the routine at TEL_LOGON.
TEL_PAUSE:
  XOR A
  LD A,$05
; This entry point is used by the routine at TMDELA.
TEL_PAUSE_0:
  CALL NZ,TMDELA_0

; Routine at 21270
;
; Used by the routines at COM_OPN, MDM_CLS, TEL_LIFT, TEL_LOGON and
; TEL_DIAL_DGT.
TMDELA:
  DEC A
  JP NZ,TEL_PAUSE_0
; This entry point is used by the routines at TEL_PAUSE and TEL_LOGON.
TMDELA_0:
  LD C,$C8
TMDELA_1:
  CALL TMDELA_2
  CALL TMDELA_2
  DEC C
  JP NZ,TMDELA_1
; This entry point is used by the routine at TEL_DIAL_DGT.
TMDELA_2:
  LD B,$AC
TMDELA_3:
  DEC B
  JP NZ,TMDELA_3
  RET

; Execute logon sequence pointed to by HL.(autodialer)
;
; Used by the routine at TEL_CALL.
TEL_LOGON:
  IN A,($BA)
  PUSH AF
  OR $08
  OUT ($BA),A
  CALL TEL_LOGON_1
  POP BC
  PUSH AF
  LD A,B
  AND $08
  LD B,A
  IN A,($BA)
  AND $F7
  OR B
  OUT ($BA),A
  POP AF
  RET NC
  CALL TEL_DISC
  CALL TEL_DISC_1
  LD A,$03
  CALL TMDELA
; This entry point is used by the routine at TEL_DISC.
TEL_LOGON_0:
  LD A,(PORT_A8)
  AND $02
  JP TEL_CONN_1
TEL_LOGON_1:
  XOR A
  LD (PORT_A8),A
  CALL TEL_LIFT_OFF
  CALL TEL_DISC_1
  CALL TMDELA_0
  CALL TEL_CONN
  CALL TEL_CONN_0
  CALL TEL_PAUSE
  DEC HL
TEL_LOGON_2:
  CALL BREAK
  RET C
  PUSH HL
  EX DE,HL
  CALL IS_CRLF
  DEC DE
  LD A,(DE)
  POP HL
  JP Z,TEL_LOGON_3
  CP $1A		; EOF
  JP Z,TEL_LOGON_3
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  JP Z,TEL_LOGON_3
  PUSH AF
  CALL C,TEL_DIAL_DGT
  POP AF
  JP C,TEL_LOGON_2
  CP '<'
  SCF
  JP Z,TEL_LOGON_3
  CP '='
  CALL Z,TEL_PAUSE
  JP TEL_LOGON_2
  
TEL_LOGON_3:
  PUSH AF
  LD A,(DIAL_SPEED)
  RRCA
  CALL NC,TMDELA_0
  POP AF
  JP NC,TEL_DISC
  LD A,(STAT)
  CP $4D	; 'M'
  SCF
  RET NZ
  PUSH HL
  LD HL,$F65C		;   HL = zero terminated setup string, e.g. "78E1E"
  AND A
  CALL SETSER
  LD A,$04
  CALL TMDELA
  POP HL
  CALL TEL_LIFT
  RET C
TEL_LOGON_4:
  CALL TEL_UPLD_7
  CALL TEL_LOGON_10
  RET Z
  CP '>'
  RET Z
  CP '='
  JP Z,TEL_LOGON_6
  CP '^'
  JP Z,TEL_LOGON_9
  CP '?'
  JP Z,TEL_LOGON_7
  CP '!'
  CALL Z,TEL_LOGON_10
  RET Z
TEL_LOGON_5:
  CALL SD232C
  XOR A
  INC A
TEL_LOGON_6:
  CALL Z,TEL_PAUSE
  JP TEL_LOGON_4
  
TEL_LOGON_7:
  CALL TEL_LOGON_10
  RET Z
TEL_LOGON_8:
  CALL RV232C
  RET C
  RST OUTDO
  CP (HL)
  JP NZ,TEL_LOGON_8
  JP TEL_LOGON_4

TEL_LOGON_9:
  CALL TEL_LOGON_10
  RET Z
  AND $1F
  JP TEL_LOGON_5
TEL_LOGON_10:
  INC HL
  LD A,(HL)
  AND A
  RET

; Dial the digit that is present in the A register.
;
; Used by the routine at TEL_LOGON.
; Pulse dialing loop
;
TEL_DIAL_DGT:
  RST OUTDO
  DI
  
  AND $0F
  LD C,A
  JP NZ,DIAL_DGT_LOOP1
  LD C,$0A

DIAL_DGT_LOOP1:
  LD A,(DIAL_SPEED)
  RRCA
  LD DE,$161C	; D=22, E=28
  JP NC,TEL_DIAL_DGT_1
  LD DE,$2440	; D=36, E=64

TEL_DIAL_DGT_1:
  CALL TEL_LIFT_OFF
DIAL_DGT_LOOP2:
  CALL TMDELA_2
  DEC E
  JP NZ,DIAL_DGT_LOOP2
  CALL TEL_LIFT_ON
TEL_DIAL_DGT_3:
  CALL TMDELA_2
  DEC D
  JP NZ,TEL_DIAL_DGT_3
  DEC C
  JP NZ,DIAL_DGT_LOOP1

  EI
  LD A,(DIAL_SPEED)
  AND $01
  INC A
  JP TMDELA


ENDIF


; Message at 21571
TERM_BAR:
  DEFM "Pre"
  DEFB 'v'+$80
  DEFM "Dow"
  DEFB 'n'+$80
  DEFM " U"
  DEFB 'p'+$80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFM "By"
  DEFB 'e'+$80


; TELCOM TERM instruction routine
TEL_TERM:

IF KC85 | M10
  RST $38
  DEFB HC_COMOPN  ;62

  LD HL,STAT
  CALL SETSER
ENDIF

IF M100
  LD HL,STAT-1
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL NC,INCHL
  PUSH AF
  CALL SETSER
  POP AF
  CCF
  CALL C,TEL_LIFT
  JP C,TEL_BYE_0
ENDIF

; This entry point is used by the routine at TEL_CALL.
TEL_TERM_0:
  LD A,$40
  LD (FNK_FLAG),A
  LD (CURLIN+1),A
  XOR A
  LD (CAPTUR),A		;
  LD (CAPTUR+1),A
  CALL CLR_ALTLCD
  LD HL,TERM_BAR
  CALL STFNK
  CALL DUPDSP		; Display terminal 'DUPLEX' status
  CALL ECHDSP		; Display terminal 'ECHO' status
  CALL WATDSP		; Display 'Wait' status/message
  CALL DSPFNK
  CALL CURSON

; This entry point is used by the routines at DWNLDR and TEL_BYE.
TEL_TERM_LOOP:
  CALL RESTAK
  LD HL,TEL_TERM_TRAP
  LD (ERRTRP),HL
  LD A,(XONXOFF_FLG)
  AND A
  JP Z,TEL_TERM_2
  LD A,(ENDLCD)
  LD HL,FNKSTR+80				; (same on KC85) ..inside the FN key definition area, also used as a status bar
  XOR (HL)
  RRCA
  CALL C,WATDSP		; Display 'Wait' status/message
TEL_TERM_2:
  CALL CHSNS
  JP Z,TEL_TERM_3
  CALL CHGET
IF KC85 | M10
  LD B,A
ENDIF
  JP C,TEL_TERM_6
IF M100
  LD B,A
  LD A,(DUPLEX)
ENDIF
  AND A
IF M100
  LD A,B
  CALL Z,_OUTDO
  AND A
ENDIF
  CALL NZ,SD232C
  JP C,TEL_TERM_INTRPT
IF KC85 | M10
  LD A,(DUPLEX)
  AND A
  LD A,B
  CALL Z,_OUTDO
ENDIF
TEL_TERM_3:
  CALL RCVX
  JP Z,TEL_TERM_LOOP
  CALL RV232C
IF KC85 | M10
  LD B,A
ENDIF
  JP C,TEL_TERM_LOOP
  RST OUTDO
IF KC85 | M10
  CALL TEL_TERM_4
ENDIF
IF M100
  LD B,A
  LD A,(ECHO)
  AND A
  LD A,B
  CALL NZ,OUTC_TABEXP
ENDIF
  CALL DWNLDR_3
  JP TEL_TERM_LOOP

IF KC85 | M10
TEL_TERM_4:
  LD B,A
  LD A,(ECHO)
  AND A
  LD A,B
  RET Z
  JP OUTC_TABEXP
ENDIF


TEL_TERM_INTRPT:
  XOR A
  LD (ENDLCD),A
TEL_TERM_5:
  CALL BREAK
  JP C,TEL_TERM_5
  JP TEL_TERM_LOOP

TEL_TERM_TRAP:
  CALL __BEEP
  XOR A
  LD (ECHO),A
  CALL ECHDSP		; Display terminal 'ECHO' status
  JP TEL_TERM_LOOP

TEL_TERM_6:
  LD E,A
  LD D,$FF
IF KC85 | M10
  LD HL,(TEL_F6_PIVOT)
ENDIF
IF M100
  LD HL,TEL_F6
ENDIF
  ADD HL,DE
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD DE,TEL_TERM_LOOP
  PUSH DE
  JP (HL)
  
; Start of function key vector table for TERM commands in TELCOM.
TEL_JPTAB:
  DEFW TEL_PREV
  DEFW TEL_DOWNLD
  DEFW TEL_UPLD
  DEFW TEL_DUPLEX
  DEFW TEL_ECHO
  DEFW TEL_F6
  DEFW TEL_F7
  DEFW TEL_BYE

TEL_F6:
  RST $38
  DEFB HC_TRMF6		; Offset: 50
  RET
  
TEL_F7:
  RST $38
  DEFB HC_TRMF7		; Offset: 52
  RET


; TELCOM PREV function routine
; Display previously received text page
TEL_PREV:
  CALL TEST_CRTLCD
  CALL CURSOFF
  CALL TEL_PREV_SUB
TEL_PREV_0:
  CALL CHSNS
  JP Z,TEL_PREV_0
  CALL CHGET
  CALL ESC_J_13
  CALL CURSON
  JP _ESC_X

; TELCOM FULL/HALF function routine
TEL_DUPLEX:
  LD HL,DUPLEX
  LD A,(HL)
  CPL
  LD (HL),A

; Routine at 21828
;
; Used by the routine at TEL_TERM.
; Display terminal 'DUPLEX' status
DUPDSP:
  LD A,(DUPLEX)
  LD DE,FNKSTR+48				; (same on KC85) ..inside the FN key definition area, also used as a status bar
  LD HL,FULLHALF_MSG
  JP CHGDSP

; TELCOM ECHO function routine
TEL_ECHO:
  LD HL,ECHO
  LD A,(HL)
  CPL
  LD (HL),A

; Routine at 21846
;
; Used by the routine at TEL_TERM.
; Display terminal 'ECHO' status
ECHDSP:
  LD A,(ECHO)
  LD DE,FNKSTR+64				; (same on KC85) ..inside the FN key definition area, also used as a status bar
  LD HL,ECHO_MSG
  JP CHGDSP

; Routine at 21858
;
; Used by the routine at TEL_TERM.
WATDSP:
  LD A,(ENDLCD)
  LD DE,FNKSTR+80				; (same on KC85) ..inside the FN key definition area, also used as a status bar
  LD HL,WAIT_MSG

; Routine at 21867
;
; Used by the routines at DUPDSP and ECHDSP.
CHGDSP:
  AND A
  LD BC,$0004
  JP NZ,CHGDSP_0
  ADD HL,BC
CHGDSP_0:
  LD B,C
  CALL LDIR_B
  LD B,$0C
  XOR A
CHGDSP_1:
  LD (DE),A
  INC DE
  DEC B
  JP NZ,CHGDSP_1
  JP FNKSB
 
FULLHALF_MSG:
  DEFM "FullHalf"

ECHO_MSG:
  DEFM "Echo    "
 
CR_WAIT_MSG:
  DEFB $0D
  DEFM " "

; Text at $5593
WAIT_MSG:
  DEFM "Wait "
  DEFB $00
  DEFM "  "

; TELCOM UP function routine
TEL_UPLD:
  LD HL,UPLOAD_ABORT
  LD (ERRTRP),HL
  PUSH HL
  LD A,(CAPTUR)
  AND A
  RET NZ				; RET if something is found in it
  CALL RESFPT
  LD HL,UPLMSG_0
  CALL PRINT_LINE
  CALL QINLIN			; User interaction with question mark, HL = resulting text 
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  RET Z
  LD (FNAME_END),A
  CALL COUNT_CHARS
  CALL FNAME
  RET NZ
  CALL FINDCO_0
  LD HL,FNTFND		; "No file" (file not found)
  JP Z,PRINT_LINE
  EX DE,HL
  EX (SP),HL
  PUSH HL
  LD HL,WIDTH_MSG		; "Width:"
  CALL PRINT_LINE
  CALL _INLIN			; Line input, FN keys are supported.
  RET C
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  LD A,$01
  LD (CAPTUR+1),A			;
  LD (TXT_EDITING),A
  JP Z,TEL_UPLD_0			; JP if no extra args
  
  CALL GETINT                 ; Get integer 0-255
  CP $0A		; 10
  RET C
  CP $85		; 133
  RET NC

  ; A = 10..132

  LD HL,TXT_BUF
  LD (TXT_PTR),HL
  LD (TRM_WIDTH),A
  LD (CAPTUR+1),A
  POP AF
  POP DE
  
  defb $01	; LD BC,NN
TEL_UPLD_0:
  POP AF
  POP HL
  
  PUSH DE
  PUSH HL
  CALL FNKSB
  POP HL
  POP DE
  
TEL_UPLD_1:
  LD A,(CAPTUR+1)
  DEC A
  JP Z,TEL_UPLD_3
  PUSH DE
  EX DE,HL
  LD HL,(TXT_PTR)
  EX DE,HL
  RST CPDEHL
  POP DE
  JP NZ,TEL_UPLD_3
  CALL TXT_BLOCK_SEL
  LD A,D
  AND E
  INC A
  JP NZ,TEL_UPLD_2
  LD HL,(TXT_PTR)
  LD (HL),$1A	; EOF
  INC HL
  LD (TXT_PTR),HL
TEL_UPLD_2:
  LD HL,TXT_BUF
TEL_UPLD_3:
  LD A,(HL)
  CP $1A		; EOF
  RST $38
  DEFB HC_UPLD		; Offset: 54

  JP Z,TEL_UPLD_STOP
  CP $0A         ; LF
  JP NZ,TEL_UPLD_4
  LD A,(RS232LF)
  AND A
  JP NZ,TEL_UPLD_4
  LD A,(FNAME_END)
  CP $0D         ; CR
TEL_UPLD_4:
  LD A,(HL)
  LD (FNAME_END),A
  JP Z,TEL_UPLD_5
  CALL SD232C
  CALL TEL_UPLD_7
TEL_UPLD_5:
  INC HL
  CALL CHSNS
  JP Z,TEL_UPLD_1
  CALL CHGET
  CP $03		; CTL_C ?
  JP Z,TEL_UPLD_STOP
  CP $13		; PAUSE ?
  CALL Z,CHGET
  CP $03		; CTL_C ?
  JP NZ,TEL_UPLD_1

TEL_UPLD_STOP:
  XOR A
  LD (CAPTUR+1),A
  JP FNKSB

; This entry point is used by the routine at TEL_LOGON.
TEL_UPLD_7:
  CALL RCVX
  RET Z
  CALL RV232C
IF KC85 | M10
  RET C
ENDIF
  RST OUTDO
  JP TEL_UPLD_7

; TELCOM DOWN function routine
TEL_DOWNLD:
  CALL RESFPT
  LD A,(CAPTUR)
  XOR $FF
  LD (CAPTUR),A
  JP Z,DWNLDR_2
  LD HL,DOWNLOAD_ABORT

; Routine at 22159
DWNLDR:
  LD (ERRTRP),HL
  PUSH HL
  LD HL,DWNFMSG		; "File to Download"
  CALL PRINT_LINE
  CALL QINLIN			; User interaction with question mark, HL = resulting text 
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  RET Z
  LD (FNAME_END),A
  POP AF
DWNLDR_0:
  PUSH HL
  CALL OPENDO
  JP C,DWNLDR_1
  LD (SV_TXTPOS),HL
  CALL GET_TXTEND
  POP AF
  CALL TXT_CTL_C_15
  JP FNKSB
 
DWNLDR_1:
  EX DE,HL
  CALL KILLASC+1
  POP HL
  JP DWNLDR_0

; This entry point is used by the routine at TEL_DOWNLD.
DWNLDR_2:
  CALL FNKSB
  JP TXT_WIPE_END

; This entry point is used by the routine at TEL_TERM.
DWNLDR_3:
  LD C,A
  LD A,(CAPTUR)
  AND A
  LD A,C
  RET Z
  CALL DWNLDR_6
  RET Z
  JP NC,DWNLDR_4
  CALL DWNLDR_4
  LD A,$0A		; 10
DWNLDR_4:
  LD HL,(SV_TXTPOS)
  CALL TXT_SPLIT_ROW
  LD (SV_TXTPOS),HL
  RET NC		; RET if at the end of text

DOWNLOAD_ABORT:
  XOR A
  LD (CAPTUR),A
  CALL FNKSB
  LD HL,DWNMSG
  JP PRS_ABORTMSG

UPLOAD_ABORT:
  LD HL,UPLMSG

PRS_ABORTMSG:
  CALL PRINT_LINE
  LD HL,ABTMSG
  CALL PRS
  JP TEL_TERM_LOOP

; This entry point is used by the routine at TXT_CTL_V.
DWNLDR_6:
  LD C,A
  AND A
  RET Z
  CP $1A		; EOF
  RET Z
  CP $7F		; BS
  RET Z
  CP $0A         ; LF
  JP NZ,DWNLDR_7
  LD A,(FNAME_END)
  CP $0D         ; CR
DWNLDR_7:
  LD A,C
  LD (FNAME_END),A
  RET Z
  CP $0D         ; CR
  SCF
  CCF
  RET NZ
  AND A
  SCF
  RET


; TELCOM BYE function routine
TEL_BYE:

IF KC85 | M10
  CALL CONSOLE_CRLF
  RST $38
  DEFB HC_COMCLS
ENDIF

IF M100
  LD HL,DISMSG
  CALL PRINT_LINE
  CALL QINLIN			; User interaction with question mark, HL = resulting text 
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL UCASE
  CP $59
  JP Z,TEL_BYE_0
  LD HL,ABTMSG
  CALL PRINT_LINE
  JP TEL_TERM_LOOP
ENDIF

; This entry point is used by the routine at TEL_TERM.
TEL_BYE_0:
  XOR A
  LD (FNK_FLAG),A
  LD L,A
  LD H,A
  LD (CAPTUR),HL
  CALL CLSCOM
  CALL CURSOFF

IF M100
  CALL TEL_DISC
ENDIF  

  CALL MCLEAR_0
  JP TELCOM


UPLMSG_0:
  DEFM "File to "
UPLMSG:
  DEFM "Upload"
  DEFB $00
  
DWNFMSG:
  DEFM "File to "
DWNMSG:
  DEFM "Download"
  DEFB $00

ABTMSG:
  DEFM " aborted"
  DEFB $0D
  DEFB $0A
  DEFB $00

FNTFND:
  DEFM "No file"
  DEFB $0D
  DEFB $0A
  DEFB $00

IF M100
DISMSG:
  DEFM "Disconnect"       ; Disconnected
  DEFB $00
ENDIF



; Print the buffer pointed to by HL till a null or '"' is found. CR if not at
; beginning of a line.
;
; Used by the routines at LOAD_RECORD, PRPARM, CAS_OPNI_CO, TELCOM_RDY, TEL_UPLD,
; DWNLDR and TEL_BYE.
PRINT_LINE:
  CALL CONSOLE_CRLF
  JP PRS

; MENU Statement.  Go to main menu
;
; Used by the routines at LDIR_B, SCHEDL_DE, L5D3D, TEXT and BOOT.
__MENU:
  LD HL,(MEMSIZ)
  LD (STKTOP),HL
  CALL _CLVAR
  CALL CLSCOM
  CALL MCLEAR_0
  CALL RESFPT
  CALL EXTREV		; Exit from reverse mode
  CALL CURSOFF
  CALL ERAFNK
  CALL LOCK
  LD A,(SCREEN)
  LD (SV_SCREEN),A
  LD A,$FF
  LD (MENU_FLG),A
  INC A
  LD (FNK_FLAG),A
  LD (LBL_LINE),A
  CALL __SCREEN_0
  CALL DISABLE_SH_PRINT
  LD HL,__MENU
  LD (ERRTRP),HL
  CALL CLRFLK
  CALL _PRINT_TDATE
  LD HL,$1C01	; cursor coordinates
  CALL POSIT
  LD HL,COPYRIGHT_MSG
  CALL PRINT_TEXT
  LD HL,MENUVARS-54
  LD (MENUVARS),HL
  LD B,$36
__MENU_1:
  LD (HL),$FF
  INC HL
  DEC B
  JP NZ,__MENU_1
  LD L,B
  LD DE,MENUTAB_TBL
__MENU_2:
  LD A,(DE)
  OR A
  JP Z,__MENU_3
  LD C,A
  PUSH DE
  CALL __MENU_21
  POP DE
  INC DE
  JP __MENU_2
  
__MENU_3:
  LD A,L
  DEC A
  LD (MENUVARS+24),A
  CP $17		; CTRL-HOME, move the cursor to beginning of the current file
  JP Z,__MENU_5
__MENU_4:
  CALL DOTTED_FNAME_1
  PUSH HL
  LD HL,NOFILE_MRK		; "-.-"
  CALL PRINT_TEXT
  POP HL
  INC L
  LD A,L
  CP $18	; TEXT down arrow
  JP NZ,__MENU_4

__MENU_5:
  SUB A
  LD (MENUVARS+2),A
  LD (MENUVARS+23),A
  LD L,A
  CALL DOTTED_FNAME_2
  LD HL,$1808	; cursor coordinates
  CALL POSIT
  CALL FREEMEM

__MENU_LOOP:
  CALL DISABLE_SH_PRINT
  LD HL,__MENU_LOOP_ERR
  LD (ERRTRP),HL
  LD HL,$0108	; cursor coordinates
  CALL POSIT
  LD HL,SELECT_PROMPT
  CALL PRINT_TEXT
  LD HL,$0908	; cursor coordinates
  CALL POSIT
  SUB A
  LD (MENUVARS+22),A
  LD HL,MENUVARS+2
  INC A
  
SELECT_LOOP:
  CALL Z,__BEEP		; BEEP if in error condition
__MENU_8:
  CALL SHOW_TIME
  CALL CHGET_UCASE
  CP $0D         ; CR
  JP Z,CR_PRESSED
  CP $08
  JP Z,BS_PRESSED
  CP $7F		; BS
  JP Z,BS_PRESSED
  CP $15
  JP Z,__MENU_LOOP
  CP ' '
  JP C,__MENU_11
  LD C,A
  LD A,(MENUVARS+22)
  CALL Z,SPC_PRESSED
  CP $09		; TAB
  JP Z,SELECT_LOOP
  CALL SHOW_TIME_0
  JP __MENU_8
  
BS_PRESSED:
  CALL _BS_PRESSED
  JP Z,SELECT_LOOP
  JP __MENU_8

SPC_PRESSED:
  OR A
  RET NZ
  POP AF
  LD A,$1C
__MENU_11:
  PUSH AF
  LD A,(MENUVARS+23)
  LD E,A
  POP AF
  SUB $1C
  LD BC,__MENU_8
  PUSH BC
  RET M
  LD BC,L58C3
  PUSH BC
  JP Z,__MENU_14
  DEC A
  JP Z,__MENU_13
  DEC A
  POP BC
  JP Z,__MENU_12
  LD A,E
  ADD A,$04
  LD D,A
  LD A,(MENUVARS+24)
  CP D
  RET M
  LD A,D

; Routine at 22723
L58C3:
  LD (MENUVARS+23),A
  PUSH HL
  LD HL,(CSRX)
  PUSH HL
  LD L,E
  PUSH DE
  CALL DOTTED_FNAME_2
  POP DE
  LD L,D
  CALL DOTTED_FNAME_2
  POP HL	; cursor coordinates
  CALL POSIT
  POP HL
  RET
  
__MENU_12:
  LD A,E
  SUB $04
  LD D,A
  RET M
  PUSH BC
  RET
  
__MENU_13:
  LD A,E
  DEC A
  LD D,A
  RET P
  LD A,(MENUVARS+24)
  LD D,A
  RET
  
__MENU_14:
  LD A,E
  INC A
  LD D,A
  LD A,(MENUVARS+24)
  CP D
  LD A,D
  RET P
  SUB A
  LD D,A
  RET

CR_PRESSED:
  LD A,(MENUVARS+22)
  OR A
  JP Z,__MENU_16
  LD (HL),$00
  CALL CHKF_0
  JP NZ,__MENU_19

; Routine at 22790
__MENU_LOOP_ERR:
  CALL __BEEP
  JP __MENU_LOOP

__MENU_16:
  LD A,(MENUVARS+23)
  LD HL,MENUVARS-54
  LD DE,$0002
__MENU_17:
  OR A
  JP Z,__MENU_18
  ADD HL,DE
  DEC A
  JP __MENU_17
  
__MENU_18:
  CALL GTXTTB_0
__MENU_19:
  PUSH HL
  CALL __CLS
  CALL UNLOCK
  LD A,(SV_SCREEN)
  CALL __SCREEN_0
  LD A,$0C
  RST OUTDO
  SUB A		; 0
  LD (MENU_FLG),A
  LD L,A
  LD H,L
  LD (ERRTRP),HL
  DEC A
  LD (LBL_LINE),A
  POP HL
  LD A,(HL)
  CALL GTXTTB
  CP $A0			; CO file type ?
  JP Z,MENU_LDEXEC
  CP $B0			; System file ?
  JP Z,CALLHL
  CP $F0			; (pehaps cold boot file type?)
  JP Z,$F624
  CP $C0			; DO file type ?
  JP Z,EDIT_TEXT
  LD (BASTXT),HL	; Otherwise, consider it a BAsic program
  DEC DE
  DEC DE
  EX DE,HL
  LD (DIRPNT),HL
  CALL LINKER
  CALL LOAD_BA_LBL
  CALL BASIC_1
IF M100 | M10
  CALL RUN_FST
ENDIF
IF KC85
  CALL _RUN_FST
ENDIF
IF M10
  JP _RUN_FST
ELSE
  JP NEWSTT
ENDIF

CALLHL:
  JP (HL)

__MENU_21:
  LD B,$1B
  LD DE,DIRECTORY
__MENU_22:
  LD A,(DE)
  INC A
  RET Z
  DEC A
  CP C
  JP NZ,__MENU_23
  PUSH BC
  PUSH DE
  PUSH HL
  LD HL,(MENUVARS)
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  INC DE
  INC DE
  INC DE
  LD (MENUVARS),HL
  POP HL
  CALL DOTTED_FNAME_1
  PUSH HL
  LD HL,MENUVARS+2
  PUSH HL
  CALL DOTTED_FNAME
  POP HL
  CALL PRINT_TEXT
  POP HL
  INC L
  POP DE
  POP BC
__MENU_23:
  PUSH HL
  LD HL,11
  ADD HL,DE
  EX DE,HL
  POP HL
  DEC B
  JP NZ,__MENU_22
  RET

; Convert filename from right justified extention to normal dotted format
;
; Used by the routines at __MENU and CHKF.
DOTTED_FNAME:
  LD A,$06
  CALL MOVE_MEM
  LD A,' '
DOTTED_FNAME_0:
  DEC HL
  CP (HL)
  JP Z,DOTTED_FNAME_0
  INC HL
  LD (HL),$00
  LD A,(DE)
  CP ' '
  RET Z
  LD (HL),'.'
  INC HL
  CALL MOVE_2_BYTES
  LD (HL),$00
  RET

; This entry point is used by the routine at __MENU.
DOTTED_FNAME_1:
  PUSH DE
  PUSH HL
  LD A,L
  RRA
  RRA
  AND $3F
  LD E,A
  INC E
  INC E
  LD A,L
  AND $03
  ADD A,A
  LD D,A
  ADD A,A
  ADD A,A
  ADD A,D
  LD D,A
  INC D
  INC D
  EX DE,HL	; cursor coordinates
  CALL POSIT
  POP HL
  POP DE
  RET

; This entry point is used by the routine at __MENU.
DOTTED_FNAME_2:
  CALL ESC_NOCURSOR
  CALL DOTTED_FNAME_1
  LD B,$0A
  PUSH HL
  LD HL,CSRY
  DEC (HL)
DOTTED_FNAME_3:
  PUSH BC
  PUSH DE
  LD HL,(CSRX)
IF M100
  CALL ESC_J_9
ENDIF
  EX DE,HL
  CALL MOVE_CURSOR
  DI
  CALL PUT_SHAPE
  EI
  POP DE
  LD HL,CSRY
  INC (HL)
  POP BC
  DEC B
  JP NZ,DOTTED_FNAME_3
  CALL ESC_NOCURSOR
  POP HL
  RET

; Print time, day, and date on the first line of the screen
;
; Used by the routine at __MENU.
_PRINT_TDATE:
  CALL __CLS

; Same as _PRINT_TDATE but screen is not cleared.
;
; Used by the routine at SHOW_TIME.
PRINT_TDATE:
  CALL CURS_HOME
  LD HL,ALT_LCD+203
  CALL GET_DATE
  LD (HL),' '
  INC HL
  CALL GET_DAY
  EX DE,HL
  LD (HL),' '
  INC HL
  CALL READ_TIME
  LD (HL),$00

IF KC85 | M10
  LD DE,ALT_LCD+203
  LD HL,ALT_LCD+200
  PUSH HL
  CALL MOVE_2_BYTES
  LD (HL),' '
  INC HL
  PUSH HL
ENDIF

  LD A,(MONTH)
  LD HL,MONTHS-3
  LD BC,$0003
PRINT_TDATE_0:
  ADD HL,BC
  DEC A
  JP NZ,PRINT_TDATE_0
  
IF M100
  LD DE,ALT_LCD+200
  EX DE,HL
  PUSH HL
  LD A,C
  CALL MOVE_MEM
  LD D,H
  LD E,L
  LD (HL),' '
  INC DE
  INC DE
  INC DE
  INC HL
  CALL MOVE_2_BYTES
ENDIF

IF KC85 | M10
  EX DE,HL
  POP HL
  LD A,$03
  CALL MOVE_MEM
ENDIF

IF KC85
  LD (HL),','
  INC HL
  LD (HL),'1'
  INC HL
  LD (HL),'9'
  POP HL
ELSE
  LD (HL),','
  INC HL
  LD (HL),'2'
  INC HL
  LD (HL),'0'
  POP HL
ENDIF

; Print the buffer pointed to by HL, null terminated.
;
; Used by the routines at TEL_SET_STAT, TEL_CALL, __MENU, SCHEDL_DE and
; SHOW_TIME.
PRINT_TEXT:
  LD A,(HL)
  OR A
  RET Z
  RST OUTDO
  INC HL
  JP PRINT_TEXT
  
; This entry point is used by the routines at DOTTED_FNAME and PRINT_TDATE.
MOVE_2_BYTES:
  LD A,$02		; 6 on PC8201 and KC85

; Move A bytes from (DE) to (HL)
;
; Used by the routines at DOTTED_FNAME, PRINT_TDATE and CHKF.
MOVE_MEM:
  PUSH AF
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  POP AF
  DEC A
  JP NZ,MOVE_MEM
  RET

; Compare the buffer pointed to by DE to the buffer pointed to by HL for C
; bytes or until a null is found
;
; Used by the routine at CHKF.
COMP_MEM:
  LD A,(DE)
  CP (HL)
  RET NZ
  OR A
  RET Z
  INC HL
  INC DE
  DEC C
  JP NZ,COMP_MEM
  RET

; Clear (wipe) function key definition table
;
; Used by the routine at __MENU.
CLRFLK:
  LD HL,EMPTY_FNTAB

; Set new function key table, HL=address of fn table. Up to 16 chars for each
; of the 8 FN keys.
;
; Used by the routines at STDSPF, TELCOM, TEL_TERM, SCHEDL_DE, IS_CRLF, TEXT,
; WAIT_SPC and BOOT.
STFNK:
  LD DE,FNKSTR
  LD B,$08
STFNK_0:
  LD C,$10
STFNK_1:
  LD A,(HL)
  INC HL
  OR A
  PUSH AF
  AND $7F
  LD (DE),A
  POP AF
  JP M,STFNK_2
  INC DE
  DEC C
  JP NZ,STFNK_1
STFNK_2:
  SUB A
STFNK_3:
  INC DE
  DEC C
  LD (DE),A
  JP NZ,STFNK_3
  DEC B
  JP NZ,STFNK_0

; Display function keys on 8th line if enabled
;
; Used by the routines at OUTS_B_CHARS, CHGDSP, TEL_UPLD, DWNLDR and BASIC.
FNKSB:
  LD A,(LABEL_LN)		; Label line/8th line protect status (0=off)
  OR A
  CALL NZ,DSPFNK
  RET

; Routine at 23206
;
; Used by the routine at TEL_FIND.
FNDFLO:
  LD DE,ADRS_DO

; Search for file in directory, DE point to filename to find, zero terminated.
; HL=TOP addr, Z if not found.
;
; Used by the routine at SCHEDL_DE.
CHKDOC:
  LD A,$08

; Routine at 23211
CHKF:
  LD HL,MENUVARS+2
  CALL MOVE_MEM
; This entry point is used by the routine at __MENU.
CHKF_0:
  LD B,$1B
  LD DE,DIRECTORY
; This entry point is used by the routine at INRC.
CHKF_1:
  LD HL,MENUVARS+25
  LD A,(DE)
  INC A
  RET Z
  AND $80
  JP Z,INRC_1
  PUSH DE
  INC DE
  INC DE
  INC DE
  PUSH HL
  CALL DOTTED_FNAME
  POP HL
  LD C,$09
  LD DE,MENUVARS+2
  CALL COMP_MEM
  JP NZ,INRC_0
  POP HL

; Routine at 23254
INRC:
  INC C
  RET

; This entry point is used by the routine at CHKF.
INRC_0:
  POP DE
; This entry point is used by the routine at CHKF.
INRC_1:
  LD HL,11
  ADD HL,DE
  EX DE,HL
  DEC B
  JP NZ,CHKF_1
  RET

; Get TOP addr of a file, HL=address of directory entry for file, exit: HL=TOP addr.
; $5AE3
; Used by the routines at TEL_FIND, __MENU and SCHEDL_DE.
; 
GTXTTB:
  INC HL
; This entry point is used by the routine at __MENU.
GTXTTB_0:
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  RET
  

MONTHS:
  DEFM "JanFebMarAprMayJunJlyAugSepOctNovDec"
  
COPYRIGHT_MSG:
  DEFM "(C)Microsoft"
  DEFB $00


NOFILE_MRK:
  DEFM "-.-"
  DEFB $00

MENUTAB_TBL:
  DEFB $B0
  DEFB $F0
  DEFB $C0
  DEFB $80
  DEFB $A0
  DEFB $00

SELECT_PROMPT:
  DEFM "Select: _         "
  DEFB $00
  
BACKSPACE_PROMPT:
  DEFM " "
  DEFB $08
  DEFB $08

UNDERSCORE_PROMPT:
  DEFM "_"
  DEFB $08

NULL_DATA:
  DEFW $0000

EMPTY_FNTAB:
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80

; ROM copy of the function key table
FNKTAB:
  DEFM "Files"
  DEFB $8D
  DEFM "Load "
  DEFB $A2
  DEFM "Save "
  DEFB $A2
  DEFM "Run"
  DEFB $8D
  DEFM "List"
  DEFB $8D
  DEFB $80
  DEFB $80
  DEFM "Menu"
  DEFB $8D

; Entry to ADDReSS  application
ADDRSS:
  LD DE,ADRS_DO

; Enter ADDReSS using the filename pointed to by DE
ADDRSS_DE:
  SUB A
  JP SCHEDL_DE_0

; Entry to SCHEDuLe  application
SCHEDL:
  LD DE,NOTE_DO

; Enter SCHEDuLe using the filename pointed to by DE
SCHEDL_DE:
  LD A,$FF
; This entry point is used by the routine at ADDRSS_DE.
SCHEDL_DE_0:
  LD (MENUVARS+22),A
  CALL DISABLE_SH_PRINT
  PUSH DE
  CALL CHKDOC
  CALL GTXTTB
  JP NZ,SCHEDL_DE_1
  POP HL
  LD (MENUVARS+23),HL
SCHEDL_TRAP:
  LD HL,SCHEDL_TRAP
  LD (ERRTRP),HL
  CALL __CLS
  CALL __BEEP
  LD HL,(MENUVARS+23)
  CALL PRINT_TEXT
  LD HL,ADR_NOT_FOUND
  CALL PRINT_TEXT
  LD HL,MENU_MSG
  CALL BANNER
  JP __MENU

SCHEDL_DE_1:
  LD (MENUVARS),HL
  CALL __CLS
  LD HL,NOTE_BAR
  CALL STDSPF
  LD HL,L5BE2 
  LD (ERRTRP),HL
; This entry point is used by the routine at SCL_LFND.
SCHEDL_DE_2:
  CALL RESTAK
  SUB A
  LD (PRTFLG),A
  LD HL,ADR_ADRS
  LD A,(MENUVARS+22)
  OR A
  JP Z,SCHEDL_DE_3
  LD HL,ADR_SCHD
SCHEDL_DE_3:
  CALL PRINT_TEXT
  CALL _INLIN		; Line input, FN keys are supported.
  INC HL
  LD A,(HL)
  OR A
  JP Z,SCHEDL_DE_2
  LD DE,SCH_JPTAB
  CALL PARSE_COMMAND
  RET NZ

; Routine at 23522
L5BE2:
  SUB A
  LD (PRTFLG),A
  CALL CONSOLE_CRLF
  CALL __BEEP
  LD HL,NOTE_BAR
  CALL STFNK
  JP SCHEDL_DE_2

; FIND instruction for ADDRSS/SCHEDL
SCH_FIND:
  SUB A
  defb $01	; LD BC,NN

; LFND instruction for ADDRSS/SCHEDL
SCL_LFND:
  LD A,$FF
  CALL SHOW_TIME_3
SCL_LFND_0:
  CALL FIND_TEXT
  JP NC,SCHEDL_DE_2
  PUSH HL
  PUSH DE
  CALL NO_TEXTMODE
SCL_LFND_1:
  CALL TXT_BLOCK_SEL
  LD A,(MENUVARS+23)
  LD (PRTFLG),A
  CALL TXT_PRINTBLOCK		; Ouput text in the memory range between DE and HL
  SUB A
  LD (PRTFLG),A
  LD A,(MENUVARS+23)
  OR A
  JP NZ,SCL_LFND_2
  CALL SHOW_TIME_8
  JP Z,SCHEDL_DE_2
SCL_LFND_2:
  DEC DE
  LD A,(DE)
  INC DE
  CP $0A
  JP Z,SCL_LFND_3
  PUSH DE
  INC DE
  LD A,E
  OR D
  POP DE
  JP NZ,SCL_LFND_1
  JP SCHEDL_DE_2
SCL_LFND_3:
  POP DE
  CALL NEXT_CRLF
  POP HL
  JP SCL_LFND_0

; Find the text specified in (HL) in (DE), null terminated
;
; Used by the routines at TEL_FIND, SCL_LFND and TXT_CTL_N.
FIND_TEXT:
  PUSH DE
FIND_TEXT_0:
  PUSH HL
  PUSH DE
FIND_TEXT_1:
  LD A,(DE)
  CALL UCASE
  LD C,A
  CALL MAKUPL
  CP C
  JP NZ,FIND_TEXT_2
  INC DE
  INC HL
  JP FIND_TEXT_1
FIND_TEXT_2:
  CP $00
  LD A,C
  POP BC
  POP HL
  JP Z,FIND_TEXT_3
  CP $1A		; EOF
  JP Z,IS_CRLF_2
  CALL IS_CRLF
  JP NZ,FIND_TEXT_0
  POP AF
  JP FIND_TEXT
FIND_TEXT_3:
  POP DE
  SCF
  RET

; Incremented DE past the next CRLF in the text file
;
; Used by the routines at TEL_FIND and SCL_LFND.
NEXT_CRLF:
  CALL IS_CRLF
  JP NZ,NEXT_CRLF
  RET

; Check the next byte(s) in the buffer pointed to by DE for a CRLF
;
; Used by the routines at TEL_FIND, TEL_LOGON, FIND_TEXT and NEXT_CRLF.
IS_CRLF:
  LD A,(DE)
  CP $0D         ; CR
  INC DE
  RET NZ
  LD A,(DE)
  CP $0A         ; LF
  RET NZ
  INC DE
  RET



; This entry point is used by the routine at TEL_FIND.
FIND_OPTIONS:
  PUSH DE
  LD HL,FIND_BAR
  CALL STFNK
  CALL CMQ_OPTIONS
  PUSH AF
  LD HL,TELCOM_BAR
IS_CRLF_1:
  CALL STFNK
  CALL SHOW_TIME_4
  POP AF
  CP 'Q'
; This entry point is used by the routine at FIND_TEXT.
IS_CRLF_2:
  POP DE
  RET
  
; This entry point is used by the routine at SHOW_TIME.
ADRSCL_OPTIONS:
  PUSH DE
  LD HL,ADRSCL_BAR
  CALL STFNK
MQ_OPTIONS:
  CALL CMQ_OPTIONS
  CP 'C'
  JP Z,MQ_OPTIONS
  PUSH AF
  LD HL,NOTE_BAR  
  JP IS_CRLF_1

CMQ_OPTIONS:
  CALL CHGET
  PUSH AF
  SUB A
  LD (FNKPNT+1),A
  POP AF
  CALL UCASE
  CP 'Q'
  RET Z
  CP ' '
  RET Z
  CP 'M'
  RET Z
  CP 'C'
  RET Z
  CP $0D	; CR
  JP NZ,CMQ_OPTIONS
  ADD A,$36
  RET
  
; Message at 23758
ADRS_DO:
  DEFM "ADRS.DO"
  DEFB $00
  
ADR_NOT_FOUND:
  DEFM " not found"
  DEFB $00
  
ADR_ADRS:
  DEFM "Adrs: "
  DEFB $00
  
ADR_SCHD:
  DEFM "Schd: "
  DEFB $00


;
; Start of ADDRSS/SCHEDL instruction vector table. Each entry starts with a 4
; byte instruction name followed by routine location.
SCH_JPTAB:
  DEFM "FIND"
  DEFW SCH_FIND
  
  DEFM "LFND"
  DEFW SCL_LFND

  DEFM "MENU"
  DEFW __MENU

  DEFB $FF
  
; Message at 23810
NOTE_DO:
  DEFM "NOTE.DO"
  DEFB $00

NOTE_BAR:
  DEFM "Find"
  DEFB ' '+$80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFM "Lfnd"
  DEFB ' '+$80
  DEFB $80
  DEFB $80
  DEFM "Menu"
  DEFB CR+$80
  
ADRSCL_BAR:
  DEFB $80
  DEFB $80
  DEFM "Mor"
  DEFB 'e'+$80
  DEFM "Qui"
  DEFB 't'+$80
  DEFB $80
  DEFB $80
  DEFB $80


FIND_BAR:
  DEFB $80
  DEFM "Call"
  DEFB ' '+$80
  DEFM "Mor"
  DEFB 'e'+$80
  DEFM "Qui"
  DEFB 't'+$80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80

IF M100
; Routine at 23869
L5D3D:
  JP __MENU
ENDIF

; Routine at 23872
L5D40:
  LD DE,CHRGTB
  ADD HL,DE
  DEC C
  RET
  
; This entry point is used by the routines at IS_CRLF and SHOW_TIME.
L5D40_0:
  LD A,(HL)
  INC HL
  CP ' '
  RET Z
  DEC HL
  RET
  
; This entry point is used by the routines at __MENU and SCHEDL_DE.
DISABLE_SH_PRINT:
  LD HL,NULL_DATA
  LD (SHFT_PRINT),HL		; ptr to entry for SHIFT-PRINT shortcut

; Routine at 23891
;
; Used by the routines at TELCOM_RDY, TEXT, WAIT_SPC and BOOT.
STKINI:
  LD HL,$FFFF
  LD (CURLIN),HL		; Set interpreter in 'DIRECT' (immediate) mode
  INC HL
  LD (CAPTUR),HL

; Routine at 23901
;
; Used by the routines at TEL_TERM and SCHEDL_DE.
RESTAK:
  POP BC
  LD HL,(SAVSTK)
  LD SP,HL
  PUSH BC
  RET

; Wait for character from keyboard and convert it to uppercase if nescessary.
;
; Used by the routine at __MENU.
CHGET_UCASE:
  CALL CHGET
  JP UCASE

; Home Cursor
;
; Used by the routine at PRINT_TDATE.
CURS_HOME:
  LD HL,$0101	; cursor coordinates
  JP POSIT

; Print time on top line of screen until a key is pressed.  When a key is
; pressed, the cursor position is restored.
;
; Used by the routine at __MENU.
SHOW_TIME:
  PUSH HL
  LD HL,(CSRX)
  PUSH HL
  CALL CHSNS
  PUSH AF
  CALL Z,PRINT_TDATE
  POP AF
  POP HL	; cursor coordinates
  PUSH AF
  CALL POSIT
  POP AF
  POP HL
  JP Z,SHOW_TIME
  RET
  
; This entry point is used by the routine at __MENU.
SHOW_TIME_0:
  LD (HL),C
  INC HL
  PUSH HL
  LD HL,MENUVARS+22
  INC (HL)
  LD A,C
  RST OUTDO
  LD HL,UNDERSCORE_PROMPT
  CALL PRINT_TEXT
  POP HL
  RET
  
ISZ_PROMPT:
  LD A,(MENUVARS+22)	; PROMPT offset (no. of entered bytes)
  OR A
  RET
  
; This entry point is used by the routine at __MENU.
_BS_PRESSED:
  CALL ISZ_PROMPT
  RET Z
  DEC A
  LD (MENUVARS+22),A
  DEC HL
  PUSH HL
  LD HL,BACKSPACE_PROMPT
  CALL PRINT_TEXT
  POP HL
  INC A
  RET
  
; This entry point is used by the routines at TEL_FIND and SCL_LFND.
SHOW_TIME_3:
  LD (MENUVARS+23),A
  CALL L5D40_0
  EX DE,HL
  LD HL,(MENUVARS)
  EX DE,HL

; This entry point is used by the routine at IS_CRLF.
SHOW_TIME_4:
  LD A,(ACTV_X)
  DEC A
  DEC A
  LD (MENUVARS+24),A
  RET
  
; This entry point is used by the routines at TEL_FIND and SCL_LFND.
NO_TEXTMODE:
  LD HL,ACTV_Y
  LD A,$FF
  LD (BASICMODE),A
  LD (TXT_EDITING),A
  LD A,(MENUVARS+23)
  OR A
  JP Z,SHOW_TIME_7
  LD A,$01
  LD (TXT_EDITING),A
  LD HL,TXT_WIDTH
SHOW_TIME_7:
  LD A,(HL)
  LD (TRM_WIDTH),A
  RET
  
; This entry point is used by the routine at SCL_LFND.
SHOW_TIME_8:
  LD HL,MENUVARS+24
  DEC (HL)
  CALL Z,ADRSCL_OPTIONS
  CP $51	; 'Q'
  RET

; Routine at 24046
TEXT:
  LD HL,L5DFB
  LD (ERRTRP),HL
  LD HL,TEXT_EMPTYBAR
  CALL STFNK
  XOR A

; Routine at 24059
L5DFB:
  CALL NZ,__BEEP
  CALL STKINI
  LD HL,EDFILE_MSG
  CALL PRS
  CALL QINLIN			; User interaction with question mark, HL = resulting text 
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  JP Z,__MENU		; Bck to Menu if no args
  CALL OPENDO
  JP EDIT_TEXT
  
EDFILE_MSG:
  DEFM "File to edit"
  DEFB $00

; table at $5E22
TEXT_EMPTYBAR:
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $80
  DEFB $83

; table at $5E2A
TEXT_FNBAR:
  DEFM "Find"
  DEFB $8E
  DEFM "Load"
  DEFB $96
  DEFM "Save"
  DEFB $87
  DEFB $80
  DEFM "Copy"
  DEFB $8F
  DEFM "Cut "
  DEFB $95
  DEFM "Sel "
  DEFB $8C
  DEFM "Menu"
  DEFB $1B
  DEFB $9B
  
TXT_SHPRN_ADDR:
  DEFW CPDEHL+1


; Routine at 24145
__EDIT:
  PUSH HL
  PUSH AF
  LD A,$01
  JP Z,__EDIT_0
  LD A,$FF
__EDIT_0:
  LD (EDITMODE),A
  XOR A
  LD (FILNAM+2),A
  LD HL,$2020		; "  "
  LD (FILNAM+6),HL	; point to file name ext
  LD HL,EDIT_OPN_TRP
  LD (ERRTRP),HL
  LD DE,$02+$100*RAM_DEVTYPE		; D = 'RAM' device, E = $02
  LD HL,BLANK_BYTE
  CALL _OPEN
  LD HL,EDIT_TRP
  LD (ERRTRP),HL
  POP AF
  POP HL
  PUSH HL
  JP __LIST

; This entry point is used by the routine at __LIST.
__EDIT_1:
  CALL CLOSE_STREAM
  CALL __NEW_2
  LD A,(LABEL_LN)		; Label line/8th line protect status (0=off)
  LD (SV_LABEL_LN),A
  LD HL,$0000
  LD (SAVE_CSRX),HL
__EDIT_2:
  CALL RESFPT
  CALL CLR_ALLINT
  LD HL,(EDTDIR)
  LD A,(HL)
  CP $1A		; EOF
  JP Z,__EDIT_4
  PUSH HL
  XOR A				; Text editor in BASIC mode
  LD HL,TXT_TO_BASIC		; Return location to get back from editor
  JP EDIT_TEXT_0

; Routine at 24235
TXT_TO_BASIC:
  XOR A
  LD HL,L5EEB
  LD (ERRTRP),HL
  LD HL,BLANK_BYTE
  LD D,RAM_DEVTYPE		; 'RAM' device  ($F9 on KC85 and PC8201)
  JP __MERGE_1
  
; This entry point is used by the routine at INXD.
__EDIT_3:
  CALL __CLS
__EDIT_4:
  XOR A
  LD (EDITMODE),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL KILLASC_4
  CALL _CLREG_1
  LD A,(SV_LABEL_LN)
  LD (LABEL_LN),A		; Label line/8th line protect status (0=off)
  JP BASIC_0

; Trap exit address for errors during EDITing
; Routine at 24277
EDIT_TRP:
  PUSH DE
  CALL KILLASC_4
  POP DE

; Routine at 24282
EDIT_OPN_TRP:
  PUSH DE
  XOR A
  LD (EDITMODE),A
  LD L,A
  LD H,A
  LD (ERRTRP),HL
  CALL CLOSE_STREAM
  POP DE
  JP ERROR

; Routine at 24299
L5EEB:
  LD A,E
  PUSH AF
  LD HL,(FILTAB+4)
  DEC HL
  LD B,(HL)
  DEC B
  DEC HL
  LD C,(HL)
  DEC HL
  LD L,(HL)
  XOR A
  LD H,A
  ADD HL,BC
  LD BC,$FFFF
  ADD HL,BC
  JP C,__EDIT_5
  LD L,A
  LD H,A
  
__EDIT_5:
  LD (SAVE_CSRX),HL
  CALL CLOSE_STREAM
  POP AF
  CP $07
  LD HL,ERR_MEMORY
  JP Z,__EDIT_6
  LD HL,ILLTXT_MSG
__EDIT_6:
  CALL __CLS
  CALL PRS
  LD HL,TEXT_TXT
  CALL BANNER
  JP __EDIT_2

; This entry point is used by the routine at SCHEDL_DE.
BANNER:
  PUSH HL
  LD HL,PRESS_SPC_MSG
  CALL PRS
  POP HL
  CALL PRS

; Wait for a space to be entered on keyboard
WAIT_SPC:
  CALL CHGET
  CP ' '
  JP NZ,WAIT_SPC
  RET

ILLTXT_MSG:
  DEFM "Text ill-formed"
  DEFB $07
  
; $5F48
BLANK_BYTE:
  DEFB $00

; $5F49
PRESS_SPC_MSG:
  DEFB $0D
  DEFB $0A
  DEFM "Press space bar for "
  DEFB $00

; at $5F60
TEXT_TXT:
  DEFM "TEXT"
  DEFB $00

; This entry point is used by the routines at __MENU and TEXT.
EDIT_TEXT:
  PUSH HL
  LD HL,$0000
  LD (SAVE_CSRX),HL
  LD A,$01
  LD HL,__MENU
; This entry point is used by the routine at __EDIT.
EDIT_TEXT_0:
  LD (BASICMODE),A
  LD (TXT_ESCADDR),HL
  CALL EXTREV		; Exit from reverse mode
  CALL ERAFNK
  CALL LOCK
  CALL CURSOFF
  CALL L65B9
  LD HL,TEXT_FNBAR
  CALL STFNK
  LD A,(EDITMODE)
  AND A
  JP Z,WAIT_SPC_3
  LD HL,$7845		; 'E', 'x', ..
  LD (FNKSTR+$70),HL
  LD HL,$7469		;        ..'i', t'
  LD (FNKSTR+$72),HL
WAIT_SPC_3:
  LD HL,TXT_SHPRN_ADDR
  LD (SHFT_PRINT),HL		; ptr to entry for SHIFT-PRINT shortcut
  LD A,(ACTV_Y)
  LD (TRM_WIDTH),A
  LD A,$80			; Disable top FN key row (incl. BREAK)
  LD (FNK_FLAG),A
  XOR A
  LD L,A
  LD H,A
  LD (EDTVARS),A
  LD (TXT_EDITING),A
  LD (TXT_ERRFLG),A
  LD (STRG_ASKBUF),A
  LD (TXT_SEL_BEG),HL
WAIT_SPC_4:
  POP HL
  LD (CUR_TXTFILE),HL
  PUSH HL
  CALL GET_TXTEND_CURTXT
  CALL TXT_CTL_C_15
  POP DE
  LD HL,(SAVE_CSRX)
  ADD HL,DE
  CALL GET_BOTTOMROW
  PUSH HL
  CALL TXT_CTL_V_29
  POP HL
  CALL TXT_CTL_C_9

; This entry point is used by the routines at TXT_CTL_Y, TXT_CTL_V and BOOT.
WAIT_SPC_5:
  CALL STKINI
  LD HL,WAIT_SPC_5
  LD (ERRTRP),HL
  PUSH HL
  LD A,(EDTVARS)
  LD (EDTVARS+1),A
  CALL MCLEAR_8
  LD (EDTVARS),A
  PUSH AF
  CALL MOVE_TEXT_1
  POP AF
  JP C,TXT_CTL_U_11
  CP $7F		; BS
  JP Z,TXT_CTL_H_0
  CP ' '
  JP NC,TXT_CTL_I
  LD C,A
  LD B,$00
  LD HL,CTL_JPTAB
  ADD HL,BC
  ADD HL,BC
  LD C,(HL)
  INC HL
  LD H,(HL)
  LD L,C
  PUSH HL
  LD HL,(CSRX)
TXT_NUL:
  RET
  
; Start of TEXT control character vector table (WORD ptr list starting with
; ^A).
; Data block at 24598
CTL_JPTAB:
  DEFW TXT_NUL		; $00
  DEFW TXT_CTL_A	; $01
  DEFW TXT_CTL_B	; $02
  DEFW TXT_CTL_C	; $03
  DEFW TXT_CTL_D	; $04, TEXT right arrow
  DEFW TXT_CTL_E	; $05, TEXT up arrow
  DEFW TXT_CTL_F	; $06
  DEFW TXT_CTL_G	; $07
  DEFW TXT_CTL_H	; $08
  DEFW TXT_CTL_I	; $09
  DEFW TXT_NUL		; $0A
  DEFW TXT_NUL		; $0B
  DEFW TXT_CTL_L	; $0C, enter in SETFIL mode
  DEFW TXT_CTL_M	; $0D, CR/LF  (= ENTER)
  DEFW TXT_CTL_N	; $0E
  DEFW TXT_CTL_O	; $0F
  DEFW TXT_CTL_P	; $10
  DEFW TXT_CTL_Q	; $11
  DEFW TXT_CTL_R	; $12
  DEFW TXT_CTL_S	; $13, TEXT left arrow
  DEFW TXT_CTL_T	; $14
  DEFW TXT_CTL_U	; $15
  DEFW TXT_CTL_V	; $16
  DEFW TXT_CTL_W	; $17, move the cursor to beginning of the current file
  DEFW TXT_CTL_X	; $18, TEXT down arrow (and control X routine)
  DEFW TXT_CTL_Y	; $19
  DEFW TXT_CTL_Z	; $1A
  DEFW TXT_ESC		; $1B
  DEFW TXT_CTL_D	; $1C
  DEFW TXT_CTL_S	; $1D
  DEFW TXT_CTL_E	; $1E
  DEFW TXT_CTL_X	; $1F

; TEXT ESCape routine
TXT_ESC:
  LD A,(EDTVARS+1)
  SUB $1B	; 27
  RET NZ
  LD L,A	; clear ERRTRP
  LD H,A
  LD (ERRTRP),HL
  RST $38
  DEFB HC_TEXT		; Offset: 56
  
  CALL L65B9
  CALL UNLOCK
  CALL ERAFNK
  CALL GO_BOTTOMROW
  CALL POSIT
  CALL CR_LF
  CALL TXT_WIPE_END
  LD HL,(TXT_ESCADDR)
  JP (HL)

; TEXT control P routine
; Embed control codes in text
TXT_CTL_P:
  CALL MCLEAR_8
  JP C,TXT_CTL_U_11
  AND A
  RET Z
  CP $1A		; EOF
  RET Z
  CP $7F		; BS
  RET Z

; TEXT control I routine
;
; Used by the routine at WAIT_SPC.
; Deal with TAB
TXT_CTL_I:
  PUSH AF
  CALL TXT_CTL_C
  CALL TXT_CTL_V_54
  CALL TXT_GET_CURPOS
  POP AF
; This entry point is used by the routine at TXT_CTL_M.
TXT_CTL_I_0:
  CALL TXT_SPLIT_ROW
  JP C,TXT_CTL_I_1		; JP if not at the end of text
  PUSH HL
  CALL TXT_CTL_L_0
  POP HL
  JP TXT_CTL_H_3

; This entry point is used by the routines at TXT_CTL_M, TXT_CTL_O, TXT_CTL_U
; and TXT_CTL_V.
TXT_CTL_I_1:
  CALL TXT_CTL_N_3
  PUSH HL
  LD HL,ERR_MEMORY
  CALL TXT_ERROR
  
; This entry point is used by the routines at TXT_CTL_C, TXT_CTL_N and
; MOVE_TEXT.
_POSIT:
  POP HL
  JP POSIT

; Message at 24753
ERR_MEMORY:
  DEFM "Memory full"
  DEFB $07
  DEFB $00


; TEXT control M routine
; (CR/LF, ENTER key code)
TXT_CTL_M:
  CALL TXT_CTL_C
  CALL TXT_CTL_V_54
  LD HL,(TEXT_END)
  INC HL
  LD A,(HL)
  INC HL
  OR (HL)
  JP NZ,TXT_CTL_I_1
  CALL TXT_CTL_L_0
  CALL TXT_GET_CURPOS
  LD A,$0D		; CR
  CALL TXT_SPLIT_ROW
  LD A,$0A		; LF
  JP TXT_CTL_I_0

; TEXT right arrow and control D routine
; (move cursor right)
TXT_CTL_D:
  CALL TXT_CTL_X_0
  SCF

; TEXT down arrow and control X routine
TXT_CTL_X:
  CALL NC,TXT_CTL_X_1
  JP TXT_CTL_C_0

; This entry point is used by the routine at TXT_CTL_D.
TXT_CTL_X_0:
  LD HL,(CSRX)
  LD A,(ACTV_Y)
  INC H
  CP H
  JP NC,TXT_CTL_E_2
  LD H,$01
TXT_CTL_X_1:
  INC L
  LD A,L
  PUSH HL
  CALL TXT_CTL_V_48
  LD A,E
  AND D
  INC A
  POP HL
  SCF
  RET Z
  CALL GET_BOTTOMROW
  CP L
  CALL C,TXT_CTL_C_10
  JP TXT_CTL_E_2

; TEXT control H routine
; Delete previous character (BS)
TXT_CTL_H:
  CALL TXT_CTL_C
  CALL TXT_GET_CURPOS
  CALL TXT_CTL_C_9
  CALL TXT_CTL_E_0
  RET C
  
; This entry point is used by the routine at WAIT_SPC.
TXT_CTL_H_0:
  CALL TXT_CTL_C
  CALL TXT_GET_CURPOS
  PUSH HL
  CALL TXT_CTL_C_9
  POP HL
  LD A,(HL)
  CP $1A         ; CTRL/Z  (EOF)
  RET Z
  PUSH AF
  PUSH HL
  PUSH HL
  CALL TXT_CTL_V_54
  POP HL
TXT_CTL_H_2:
  CALL MCLEAR_5
  CALL L6256
  POP HL
  POP AF
  CP $0D         ; CR
  JP NZ,TXT_CTL_H_3
  LD A,(HL)
  CP $0A         ; LF
  JP NZ,TXT_CTL_H_3
  PUSH AF
  PUSH HL
  JP TXT_CTL_H_2
  
; This entry point is used by the routine at TXT_CTL_I.
TXT_CTL_H_3:
  PUSH HL
  LD A,(CSRX)
  CALL TXT_CTL_V_31
  POP HL
  JP TXT_CTL_C_7

; TEXT left arrow (control S)
TXT_CTL_S:
  CALL TXT_CTL_E_0
  SCF

; TEXT up arrow and control E routine
; (move cursor up)
TXT_CTL_E:

  CALL NC,TXT_CTL_E_1
  JP TXT_CTL_C_0

; This entry point is used by the routines at TXT_CTL_H and TXT_CTL_S.
TXT_CTL_E_0:
  LD HL,(CSRX)
  DEC H
  JP NZ,TXT_CTL_E_2
  LD A,(ACTV_Y)
  LD H,A

TXT_CTL_E_1:
  PUSH HL
  CALL TXT_CTL_V_47
  LD HL,(CUR_TXTFILE)
  RST CPDEHL
  POP HL	; cursor coordinates
  CCF
  RET C
  DEC L		
  CALL Z,TXT_CTL_C_12
; This entry point is used by the routine at TXT_CTL_X.
TXT_CTL_E_2:
  CALL POSIT
  AND A
  RET

; TEXT control F routine
; Move the cursor to beginning of the word at right
TXT_CTL_F:
  CALL TXT_GET_CURPOS
TXT_CTL_F_0:
  CALL TXT_CTL_A_3
  JP NZ,TXT_CTL_F_0
TXT_CTL_F_1:
  CALL TXT_CTL_A_3
  JP Z,TXT_CTL_F_1
  JP TXT_CTL_A_2

; TEXT control A routine
; Move the cursor to beginning of the word at left
TXT_CTL_A:
  CALL TXT_GET_CURPOS
TXT_CTL_A_0:
  CALL TXT_CTL_A_4
  JP Z,TXT_CTL_A_0
TXT_CTL_A_1:
  CALL TXT_CTL_A_4
  JP NZ,TXT_CTL_A_1
  CALL TXT_CTL_A_3
; This entry point is used by the routine at TXT_CTL_F.
TXT_CTL_A_2:
  CALL TXT_CTL_C_7
  JP TXT_CTL_C_0

; This entry point is used by the routine at TXT_CTL_F.
TXT_CTL_A_3:
  LD A,(HL)
  CP $1A		; EOF
  POP BC
  JP Z,TXT_CTL_A_2
  INC HL
  JP TXT_CTL_A_5
TXT_CTL_A_4:
  EX DE,HL
  LD HL,(CUR_TXTFILE)
  EX DE,HL
  RST CPDEHL
  POP BC
  JP Z,TXT_CTL_A_2
  DEC HL
TXT_CTL_A_5:
  PUSH BC
  PUSH HL
  LD A,(HL)
  CALL TXT_CTL_V_27
  POP HL
  RET

; TEXT control T routine
; Move the cursor to the top of the Display in the current column
TXT_CTL_T:
  DEC L
  LD L,$01
  JP NZ,TXT_MOVE_CURSOR
  PUSH HL	; save cursor coordinates
  CALL TXT_CTL_V_47
  EX DE,HL
  CALL TXT_CTL_Z_1
  POP HL	; restore cursor coordinates
  
; This entry point is used by the routines at TXT_CTL_B and TXT_CTL_Q.
TXT_MOVE_CURSOR:
  CALL POSIT
  JP TXT_CTL_C_0

; TEXT control B routine
; Move the cursor to the bottom of display
TXT_CTL_B:
  PUSH HL
  INC L
  CALL GET_BOTTOMROW
  INC A
  CP L
  JP NZ,TXT_CTL_B_0
  PUSH AF
  CALL TXT_CTL_V_47
  EX DE,HL
  LD A,$01
  CALL TXT_CTL_Z_2
  POP AF
TXT_CTL_B_0:
  DEC A
  CALL TXT_CTL_V_48
  LD B,A
  INC DE
  LD A,D
  OR E
  LD A,B
  JP Z,TXT_CTL_B_0
  POP HL
  LD L,A
  JP TXT_MOVE_CURSOR

; TEXT control R routine
; Move the cursor to the right-most position of current line
TXT_CTL_R:
  LD A,(ACTV_Y)
  LD H,A	; cursor coordinates
  CALL POSIT
  CALL TXT_GET_CURPOS
  CALL TXT_CTL_V_55

  defb $01	; LD BC,NN
  

; TEXT control Q routine
; Move the cursor to the left-most position of current line
TXT_CTL_Q:
  LD H,$01
  JP TXT_MOVE_CURSOR

; TEXT control W routine
; Move the cursor to beginning of the current file
TXT_CTL_W:
  LD HL,(CUR_TXTFILE)
  CALL TXT_CTL_Z_3
  CALL HOME
  JP TXT_CTL_C_0

; TEXT control Z routine
; Position the cursor to the end of current file
TXT_CTL_Z:
  LD HL,(TEXT_END)
  PUSH HL
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  PUSH HL
  CALL NC,TXT_CTL_Z_1

; This entry point is used by the routine at TXT_CTL_Z and TXT_CTL_N.
TXT_CTL_Z_0:
  POP HL
  CALL TXT_CTL_C_9
  JP TXT_CTL_C_0
  
; This entry point is used by the routine at TXT_CTL_T.
TXT_CTL_Z_1:
  CALL GET_BOTTOMROW

; This entry point is used by the routine at TXT_CTL_B.
TXT_CTL_Z_2:
  CALL GET_TXTEND_1

; This entry point is used by the routine at TXT_CTL_W.
TXT_CTL_Z_3:
  CALL TXT_CKRANGE
  RET Z
  LD (EDTVARS+12),HL
  LD A,$01
  JP TXT_CTL_V_34

; TEXT control L routine
; enter in SETFIL mode
TXT_CTL_L:
  CALL TXT_CTL_C
  CALL TXT_GET_CURPOS
  LD (TXT_SEL_BEG),HL
  LD (TXT_SEL_END),HL
  LD E,L
  LD D,H
  JP TXT_CTL_C_2
  
; This entry point is used by the routines at TXT_CTL_I and TXT_CTL_M.
TXT_CTL_L_0:
  LD C,$00

  ;LD HL,$800E
  defb $21	 ;	LD HL,NN

; Routine at 25174
;
; Used by the routine at TXT_CTL_H.
L6256:
  LD C,$80
  CALL GET_BOTTOMROW
  LD HL,CSRX
  SUB (HL)
  LD B,A
  CALL TXT_CTL_V_47
  INC HL
TXT_CTL_L_1:
  INC HL
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC DE
  LD A,D
  OR E
  RET Z
  DEC C
  JP M,TXT_CTL_L_2
  DEC DE
  DEC DE
TXT_CTL_L_2:
  DEC HL
  LD (HL),E
  INC HL
  LD (HL),D
  DEC B
  JP P,TXT_CTL_L_1
  RET

; This entry point is used by the routines at TXT_CTL_C and TXT_CTL_N.
TXT_CTL_L_3:
  CALL HOME
  CALL DELLIN
  CALL GET_BOTTOMROW

; This entry point is used by the routine at MCLEAR.
TXT_CTL_L_4:
  ADD A,A
  LD B,A
  LD DE,EDTVARS+12
  LD HL,EDTVARS+14
  JP LDIR_B

; TEXT control C routine
;
; Used by the routines at TXT_CTL_I, TXT_CTL_M, TXT_CTL_H, TXT_CTL_L,
; TXT_CTL_O, TXT_CTL_U and TXT_CTL_N.
; Interrupt any type of function (Cancel SETFIL, SAVE, LOAD, FIND or PRINT)
TXT_CTL_C:
  CALL TXT_IS_SETFILING
  PUSH HL
  LD HL,$0000
  LD (TXT_SEL_BEG),HL
  CALL TXT_GET_CURPOS
  POP DE
  JP TXT_CTL_C_1
  
; This entry point is used by the routines at TXT_CTL_X, TXT_CTL_E, TXT_CTL_A,
; TXT_CTL_T, TXT_CTL_W and TXT_CTL_Z.
TXT_CTL_C_0:
  CALL TXT_IS_SETFILING
  CALL TXT_GET_CURPOS
  EX DE,HL
  LD HL,(TXT_SEL_END)
  RST CPDEHL
  RET Z
  EX DE,HL
  LD (TXT_SEL_END),HL
TXT_CTL_C_1:
  CALL TXT_CTL_U_5
  
; This entry point is used by the routine at TXT_CTL_L.
TXT_CTL_C_2:
  PUSH HL
  PUSH DE
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  JP C,TXT_CTL_C_3
  CALL GO_BOTTOMROW
TXT_CTL_C_3:
  CALL C,TXT_CTL_V_55
  LD H,L
  EX (SP),HL
  CALL TXT_CKRANGE
  JP NC,TXT_CTL_C_4
  LD L,$01
TXT_CTL_C_4:
  CALL NC,TXT_CTL_V_55
  POP AF
  SUB L
  LD C,A
  EX DE,HL
  LD HL,(CSRX)
  EX DE,HL
  PUSH DE
  LD H,$01	; cursor coordinates
  CALL POSIT
  CALL TXT_CTL_V_47
  LD A,C
TXT_CTL_C_5:
  PUSH AF
  CALL TXT_CTL_V_40
  POP AF
  DEC A
  JP P,TXT_CTL_C_5
  JP _POSIT

; This entry point is used by the routines at TXT_CTL_O, TXT_CTL_U and
; TXT_CTL_V.
TXT_IS_SETFILING:
  LD HL,(TXT_SEL_BEG)
  LD A,H
  OR L
  RET NZ
  POP HL
  RET

; This entry point is used by the routines at TXT_CTL_H and TXT_CTL_A.
TXT_CTL_C_7:
  CALL TXT_CKRANGE
  CALL C,TXT_CTL_C_13
  JP C,TXT_CTL_C_7
TXT_CTL_C_8:
  PUSH HL
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  CALL NC,TXT_CTL_C_11
  JP NC,TXT_CTL_C_8
  
; This entry point is used by the routines at WAIT_SPC, TXT_CTL_H, TXT_CTL_Z,
; TXT_CTL_U and TXT_CTL_V.
TXT_CTL_C_9:
  CALL TXT_CTL_V_55
  JP POSIT

; This entry point is used by the routine at TXT_CTL_X.
TXT_CTL_C_10:
  DEC L
TXT_CTL_C_11:
  PUSH AF
  PUSH HL
  CALL TXT_CTL_L_3
  CALL GET_BOTTOMROW
  JP TXT_CTL_C_14

; This entry point is used by the routine at TXT_CTL_E.
TXT_CTL_C_12:
  INC L
TXT_CTL_C_13:
  PUSH AF
  PUSH HL
  CALL CLR_BOTTOMROW
  CALL HOME
  CALL INSLIN
  CALL TXT_CTL_V_49
  PUSH DE
  CALL TXT_CTL_V_46
  INC HL
  LD E,L
  LD D,H
  DEC HL
  DEC HL
  DEC A
  ADD A,A
  LD C,A
  LD B,$00
  CALL _LDDR
  EX DE,HL
  POP DE
  LD (HL),D
  DEC HL
  LD (HL),E
  LD A,$01
TXT_CTL_C_14:
  CALL TXT_CTL_V_34
  POP HL
  POP AF
  RET

; This entry point is used by the routines at DWNLDR, WAIT_SPC, TXT_CTL_O and
; TXT_CTL_U.
TXT_CTL_C_15:
  LD HL,(STREND)
  LD BC,$00C8
  ADD HL,BC
  XOR A
  SUB L
  LD L,A
  SBC A,A
  SUB H
  LD H,A
  ADD HL,SP
  RET NC
  LD A,H
  OR L
  RET Z
  LD B,H
  LD C,L
  LD HL,(TEXT_END)
  EX DE,HL
  INC DE
  CALL MAKHOL_0

; Routine at 25446
MCLEAR:
  LD (HL),$00
  INC HL
  DEC BC
  LD A,B
  OR C
  JP NZ,MCLEAR
  RET

; This entry point is used by the routines at TEL_BYE and __MENU.
MCLEAR_0:
  LD HL,(DO_FILES)
MCLEAR_1:
  CALL GET_TXTEND
  INC HL
  EX DE,HL
  LD HL,(CO_FILES)
  EX DE,HL
  RST CPDEHL
  RET NC
  LD A,(HL)
  AND A
  JP NZ,MCLEAR_1

; This entry point is used by the routines at DWNLDR, TXT_ESC, TXT_CTL_O and
; TXT_CTL_U.
TXT_WIPE_END:
  LD HL,(TEXT_END)
  PUSH HL
  LD BC,$FFFF
  XOR A
TXT_WIPE_END_0:
  INC HL
  INC BC
  CP (HL)
  JP Z,TXT_WIPE_END_0
  POP HL
  INC HL
  JP MASDEL		; Delete specified no of characters, BC=number, HL=address

; This entry point is used by the routines at DWNLDR, TXT_CTL_I, TXT_CTL_M and
; TXT_CTL_V.
TXT_SPLIT_ROW:
  EX DE,HL
  LD HL,(TEXT_END)
  INC HL
  INC (HL)
  DEC (HL)
  SCF
  RET NZ	; RET if not EOF
  PUSH AF
  LD (TEXT_END),HL
  EX DE,HL
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  LD L,E
  LD H,D
  DEC HL
  CALL _LDDR
  INC HL
  POP AF
  LD (HL),A
  INC HL
  AND A
  RET

; This entry point is used by the routine at TXT_CTL_H.
MCLEAR_5:
  EX DE,HL
  LD HL,(TEXT_END)
  LD A,L
  SUB E
  LD C,A
  LD A,H
  SBC A,D
  LD B,A
  DEC HL
  LD (TEXT_END),HL
  LD L,E
  LD H,D
  INC HL
  CALL _LDIR
  XOR A
  LD (DE),A
  RET
  
; This entry point is used by the routines at ESC_B, WAIT_SPC, TXT_CTL_X,
; TXT_CTL_B, TXT_CTL_Z, TXT_CTL_L, TXT_CTL_C, TXT_CTL_U, TXT_CTL_N, MOVE_TEXT
; and TXT_CTL_V.

; Get bottom row position (7th or 8th depending on label line)
GET_BOTTOMROW:
  PUSH HL
  PUSH AF
  LD HL,LABEL_LN		; Label line/8th line protect status (0=off)
  LD A,(ACTV_X)
  ADD A,(HL)
  LD L,A
  POP AF
  LD A,L
  POP HL
  RET
  
; This entry point is used by the routines at TXT_ESC, TXT_CTL_C, MOVE_TEXT and
; TXT_CTL_V.
GO_BOTTOMROW:
  PUSH AF
  LD HL,(ACTV_X)
  CALL GET_BOTTOMROW
  LD L,A
  POP AF
  RET
  
; This entry point is used by the routines at WAIT_SPC and TXT_CTL_P.
MCLEAR_8:
  LD HL,(CSRX)
  PUSH HL
  LD A,L
  LD (LBL_LINE),A
  LD A,(LABEL_LN)
  PUSH AF
  CALL CHGET
  POP BC
  POP HL
  PUSH AF
  XOR A
  LD (LBL_LINE),A
  LD A,(LABEL_LN)
  CP B
  JP NZ,MCLEAR_9
  POP AF
  RET

MCLEAR_9:
  AND A
  JP Z,MCLEAR_10
  LD A,(CSRX)
  CP L
  LD A,(ACTV_X)
  CALL NZ,TXT_CTL_L_4
  POP AF
  RET

MCLEAR_10:
  PUSH HL
  LD A,(ACTV_X)
  DEC A
  CALL TXT_CTL_V_48
  INC HL
  LD (HL),$FE
  INC HL
  INC HL
  LD (HL),$FE
  DEC A
  CALL TXT_CTL_V_34
  XOR A
  LD (TXT_ERRFLG),A
  POP HL	; cursor coordinates
  CALL POSIT
  POP AF
  RET

; TEXT control O routine
; 'COPY' the SETFILed text
TXT_CTL_O:
  CALL TXT_IS_SETFILING
  CALL TXT_WIPE_END
  CALL TXT_CTL_U_6
  PUSH AF
  CALL TXT_CTL_C_15
  POP AF
  JP NC,TXT_CTL_C
  JP TXT_CTL_I_1

; TEXT control U routine
; same as CUT function
TXT_CTL_U:
  CALL TXT_IS_SETFILING
  CALL TXT_WIPE_END
  CALL TXT_CTL_U_6
  PUSH AF
  CALL NC,MASDEL		; Delete specified no of characters, BC=number, HL=address
  POP AF
  JP NC,TXT_CTL_U_2
  LD A,B
  AND A
  JP Z,TXT_CTL_U_1
TXT_CTL_U_0:
  CALL _RST75_6
  PUSH BC
  LD BC,$0100
  CALL TXT_CTL_U_3
  POP BC
  DEC B
  JP NZ,TXT_CTL_U_0
TXT_CTL_U_1:
  LD A,C
  AND A
  CALL NZ,TXT_CTL_U_3
TXT_CTL_U_2:
  LD DE,$0000
  EX DE,HL
  LD (TXT_SEL_BEG),HL
  EX DE,HL
  PUSH HL
  LD A,(CSRX)
  CALL TXT_CTL_V_29
  POP HL
  CALL TXT_CTL_C_9
  CALL GET_TXTEND_CURTXT
  JP TXT_CTL_C_15

TXT_CTL_U_3:
  PUSH HL
  PUSH BC
  EX DE,HL
  LD HL,(FILTAB+4)
  EX DE,HL
  CALL _LDIR
  POP BC
  POP HL
  PUSH HL
  PUSH BC
  CALL MASDEL		; Delete specified no of characters, BC=number, HL=address
  LD HL,(HAYASHI)		; Paste buffer file
  ADD HL,BC
  EX DE,HL
  POP BC
  CALL MAKHOL_0
  EX DE,HL
  LD HL,(FILTAB+4)
  CALL _LDIR
  POP HL
  RET

TXT_CTL_U_4:
  LD HL,(TXT_SEL_BEG)
  EX DE,HL
  LD HL,(TXT_SEL_END)

; This entry point is used by the routine at TXT_CTL_C.
TXT_CTL_U_5:
  RST CPDEHL
  RET C
  EX DE,HL
  RET

; This entry point is used by the routine at TXT_CTL_O.
TXT_CTL_U_6:
  CALL SWAPNM_1
  LD HL,(HAYASHI)		; Paste buffer file
  LD (PASTE_BUF),HL
  XOR A
  LD (TXT_BUFLAG),A
  CALL TXT_CTL_U_4
  DEC DE
TXT_CTL_U_7:
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  JP C,TXT_CTL_U_8
  LD A,(DE)
  CP $1A		; EOF
  JP Z,TXT_CTL_U_9
  CP $0D         ; CR
  JP NZ,TXT_CTL_U_8
  INC DE
  LD A,(DE)
  CP $0A         ; LF
  JP NZ,TXT_CTL_U_8
  INC BC
TXT_CTL_U_8:
  INC BC
TXT_CTL_U_9:
  LD A,B
  OR C
  RET Z
  PUSH HL
  LD HL,(PASTE_BUF)
  CALL MAKHOL
  EX DE,HL
  POP HL
  RET C
  LD A,(TXT_BUFLAG)
  AND A
  JP Z,TXT_CTL_U_10
  ADD HL,BC
TXT_CTL_U_10:
  PUSH HL
  PUSH BC
  CALL _LDIR
  POP BC
  POP HL
  RET

; This entry point is used by the routines at WAIT_SPC and TXT_CTL_P.
TXT_CTL_U_11:
  CALL TXT_CTL_C
  CALL TXT_WIPE_END
  CALL RESFPT
  CALL TXT_GET_CURPOS
  LD (PASTE_BUF),HL
  LD A,H
  LD (TXT_BUFLAG),A
  LD HL,(HAYASHI)		; Paste buffer file
  LD A,(HL)
  CP $1A		; EOF
  JP Z,TXT_CTL_C_15
  LD E,L
  LD D,H
  DEC DE
TXT_CTL_U_12:
  INC DE
  LD A,(DE)
  CP $1A		; EOF
  JP NZ,TXT_CTL_U_12
  CALL TXT_CTL_U_7
  PUSH AF
  PUSH DE
  CALL GET_TXTEND_CURTXT
  CALL TXT_CTL_C_15
  POP DE
  POP AF
  JP C,TXT_CTL_I_1
  PUSH DE
  LD HL,(PASTE_BUF)
  LD A,(CSRX)
  CALL TXT_CTL_V_29
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  CALL GET_BOTTOMROW
  PUSH HL
  CALL NC,TXT_CTL_V_29
  POP HL
  JP TXT_CTL_C_9

; TEXT control N routine
; FIND in text
TXT_CTL_N:
IF KC85 | M10
  CALL TXT_CTL_N_SUB
ENDIF
IF M100
  CALL TXT_CTL_N_3
ENDIF
  CALL TXT_GET_CURPOS
  PUSH HL
  LD HL,STRG_MSG
  LD DE,STRG_ASKBUF
  PUSH DE
  CALL ASK_TEXT
  POP DE
  INC HL
  LD A,(HL)
  AND A
  SCF
  JP Z,TXT_CTL_N_0		; JP if no text entered
  CALL MOVE_TEXT
  POP DE
  PUSH DE
  LD A,(DE)
  CP $1A		; EOF
  JP Z,TXT_CTL_N_1
  INC DE
  CALL FIND_TEXT
  JP NC,TXT_CTL_N_1
  POP DE
  PUSH BC
  PUSH BC
  CALL TXT_CTL_V_46
  POP HL
  RST CPDEHL
  JP C,TXT_CTL_N_0
  CALL L6981
  AND A
TXT_CTL_N_0:
  CALL C,MOVE_TEXT_2
  SCF
TXT_CTL_N_1:
  LD HL,NOMATCH_MSG
  CALL NC,TXT_ERROR
  JP TXT_CTL_Z_0

; This entry point is used by the routines at TXT_CTL_Y and TXT_CTL_G.
TXT_CTL_N_2:
  CALL TXT_CTL_C

; This entry point is used by the routine at TXT_CTL_I.
TXT_CTL_N_3:
  LD HL,(CSRX)
  CALL GET_BOTTOMROW
  CP L
  RET NZ
  DEC L
  PUSH HL
  CALL TXT_CTL_L_3
  JP _POSIT

; This entry point is used by the routines at TXT_CTL_Y and TXT_CTL_V.
TXT_ABT_ERROR:
  LD HL,ABTMSG
; This entry point is used by the routine at TXT_CTL_I.
TXT_ERROR:
  LD A,$01
  LD (TXT_ERRFLG),A
; This entry point is used by the routine at MOVE_TEXT.
TXT_CTL_N_6:
  CALL CLR_BOTTOMROW
  CALL PRS	; prints error message in HL

; Routine at 26041
;
; Used by the routine at EDIT_TEXT.
L65B9:
  CALL CHSNS
  RET Z
  CALL CHGET
  JP L65B9

; Move data from (HL) to (DE) until null is found.
;
; Used by the routines at TXT_CTL_N and TXT_CTL_Y.
MOVE_TEXT:
  PUSH HL
MOVE_TEXT_0:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  AND A
  JP NZ,MOVE_TEXT_0
  POP HL
  RET

; Routine at 26062
NOMATCH_MSG:
  DEFM "No match"
  DEFB $00

STRG_MSG:
  DEFM "String:"
  DEFB $00


; Routine at 26079
;
; Used by the routines at TXT_CTL_C and TXT_CTL_N.
CLR_BOTTOMROW:
  PUSH HL
  CALL GO_BOTTOMROW
  LD H,$01
  CALL POSIT
  POP HL
  JP ERAEOL

; This entry point is used by the routine at WAIT_SPC.
MOVE_TEXT_1:
  LD HL,TXT_ERRFLG
  XOR A
  CP (HL)
  RET Z
  LD (HL),A

; This entry point is used by the routines at TXT_CTL_N and TXT_CTL_Y.
MOVE_TEXT_2:
  LD HL,(CSRX)
  PUSH HL
  CALL GET_BOTTOMROW
  CALL TXT_CTL_V_34
  JP _POSIT

; This entry point is used by the routine at TXT_CTL_G.
MOVE_TEXT_3:
  LD DE,BLANK_BYTE

; This entry point is used by the routines at TXT_CTL_N and TXT_CTL_Y.
ASK_TEXT:
  PUSH DE
  CALL TXT_CTL_N_6
  LD A,(CSRY)
  LD (SV_CSRY),A
  POP HL
  PUSH HL
  CALL PRS
MOVE_TEXT_5:
  CALL CHGET
  JP C,MOVE_TEXT_5
  AND A
  JP Z,MOVE_TEXT_5
  POP HL
  CP $0D         ; CR
  JP Z,MOVE_TEXT_7
  PUSH AF
  CALL GO_BOTTOMROW
  LD A,(SV_CSRY)
  LD H,A	; cursor coordinates
  CALL POSIT
  CALL ERAEOL
  POP AF
  LD DE,KBUF
  LD B,$01
  AND A
  JP MOVE_TEXT_6

L663A:
  CALL CHGET
MOVE_TEXT_6:
  LD HL,L663A
  PUSH HL
  RET C
  CP $7F		; BS
  JP Z,_INLIN_BS
  CP ' '
  JP NC,MOVE_TEXT_9
  LD HL,INLIN_TBL2-2
  LD C,$07
  JP TTY_VECT_JP

  
MOVE_TEXT_7:
  LD DE,KBUF
  CALL MOVE_TEXT
  JP MOVE_TEXT_8
  

INLIN_TBL2:
  DEFB $03
  DEFW _INLIN_STOP_EDIT

  DEFB $08
  DEFW _INLIN_BS

  DEFB $09
  DEFW __INLIN_TAB

  DEFB $0D
  DEFW _INLIN_NEWLINE

  DEFB $15
  DEFW _INLIN_CTL_UX

  DEFB $18
  DEFW _INLIN_CTL_UX

  DEFB $1D
  DEFW _INLIN_BS



_INLIN_STOP_EDIT:
  LD DE,KBUF

; Routine at 26229
_INLIN_NEWLINE:
  POP HL
  XOR A
  LD (DE),A
MOVE_TEXT_8:
  LD HL,BUFMIN
  RET


; Routine at 26236
__INLIN_TAB:
  LD A,$09
MOVE_TEXT_9:
  LD C,A
  LD A,(ACTV_Y)
  SUB $09
  LD HL,CSRY
  CP (HL)
  JP C,__BEEP
  LD A,C
  INC B
  RST OUTDO
  LD (DE),A
  INC DE
  RET

; TEXT control Y routine
; print the entire file
TXT_CTL_Y:
  CALL TXT_CTL_N_2
  LD HL,TXT_ERR_NOFILE
  LD (ERRTRP),HL
  PUSH HL
  LD HL,(CSRX)
  LD (SAVE_CSRX),HL
  LD HL,WIDTH_MSG	; "Width:"
  LD DE,TXT_ASKBUF
  CALL ASK_TEXT
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  XOR A
  CP (HL)
  JP Z,TXT_EXIT_ASK		; JP if no text entered
  LD (KBUF+3),A
  CALL GETINT                 ; Get integer 0-255
  CP $0A	; 10
  RET C
  CP $85	; 133
  RET NC

  ; A = 10..132
  
  POP DE
  LD (TXT_WIDTH),A
  LD (TRM_WIDTH),A
  LD (PRTFLG),A

  LD DE,TXT_ASKBUF
  LD HL,KBUF
  CALL MOVE_TEXT
  INC A
  LD (TXT_EDITING),A
  CALL CR_LF
  LD HL,(CUR_TXTFILE)
  EX DE,HL
TXT_CTL_Y_0:
  CALL TXT_CTL_V_40
  LD A,D
  AND E
  INC A
  JP NZ,TXT_CTL_Y_0
  CALL TXT_CTL_Y_4
  
; This entry point is used by the routines at TXT_CTL_G and TXT_CTL_V.
TXT_EXIT_ASK:
  CALL MOVE_TEXT_2
TXT_CTL_Y_2:
  LD HL,(SAVE_CSRX)	; cursor coordinates
  CALL POSIT
  JP WAIT_SPC_5

; This entry point is used by the routines at TXT_CTL_G and TXT_CTL_V.
TXT_ERR_NOFILE:
  CALL TXT_CTL_Y_4
  CALL CLOSE_STREAM
  CALL TXT_ABT_ERROR
  JP TXT_CTL_Y_2

TXT_CTL_Y_4:
  LD A,(ACTV_Y)
  LD (TRM_WIDTH),A
  XOR A
  LD (PRTFLG),A
  LD (TXT_EDITING),A
  RET
  
; Message at 26380
WIDTH_MSG:
  DEFM "Width:"
  DEFB $00

; TEXT control G routine
; Save file or program
TXT_CTL_G:
  LD DE,SAVE_MSG
  CALL ASK_FILENAME
  JP C,TXT_ERR_NOFILE
  JP Z,TXT_EXIT_ASK
  LD E,$02
  CALL _OPEN
  LD HL,(CUR_TXTFILE)
TXT_CTL_G_0:
  LD A,(HL)
  RST OUTDO
  INC HL
  CP $1A		; EOF
  JP NZ,TXT_CTL_G_0
  CALL CLOSE_STREAM
  JP TXT_EXIT_ASK
  
  
; Message at 26421
SAVE_MSG:
  DEFM "Save to:"
  DEFB $00

; Routine at 26430
;
; Used by the routines at TXT_CTL_G and TXT_CTL_V.
ASK_FILENAME:
  PUSH DE
  CALL TXT_CTL_N_2
  LD HL,TXT_ERR_NOFILE
  LD (ERRTRP),HL
  LD HL,(CSRX)
  LD (SAVE_CSRX),HL
  POP HL
  CALL MOVE_TEXT_3
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  AND A
  RET Z
  CALL COUNT_CHARS
  CALL FNAME
  JP NZ,ASK_FILENAME_0
  LD D,CAS_DEVTYPE				; D = 'CAS' device
  
ASK_FILENAME_0:
  LD A,D
  CP RAM_DEVTYPE		; RAM_DEVTYPE
  SCF
  RET Z
  CP CRT_DEVTYPE
  SCF
  RET Z
  CP LCD_DEVTYPE
  SCF
  RET Z
  LD HL,BLANK_BYTE
  CCF
  LD A,$00
  RET

; TEXT control V routine
; Load file or program
TXT_CTL_V:
  LD DE,LOAD_MSG
  CALL ASK_FILENAME
  JP C,TXT_ERR_NOFILE
  JP Z,TXT_EXIT_ASK
  PUSH HL
  LD HL,L67CB
  LD (ERRTRP),HL
  LD HL,(TEXT_END)
  LD (SAVE_CSRX),HL
  LD (FNAME_END),A
  EX (SP),HL
  LD E,$01
  CALL _OPEN
  POP HL
TXT_CTL_V_0:
  CALL RDBYT
  JP C,TXT_CTL_V_2
  CALL DWNLDR_6
  JP Z,TXT_CTL_V_0
  JP NC,TXT_CTL_V_1
  CALL TXT_SPLIT_ROW
  LD A,$0A
TXT_CTL_V_1:
  CALL NC,TXT_SPLIT_ROW		; CALL if at the end of text
  JP NC,TXT_CTL_V_0
  CALL CLOSE_STREAM
  CALL TXT_CTL_I_1
TXT_CTL_V_2:
  CALL CLOSE_STREAM
TXT_CTL_V_3:
  CALL GET_TXTEND_CURTXT
  LD HL,(SAVE_CSRX)
  PUSH HL
  CALL L6981
  POP HL
  CALL TXT_CTL_C_9
  JP WAIT_SPC_5

; Routine at 26571
L67CB:
  CALL CLOSE_STREAM
  CALL TXT_ABT_ERROR
  JP TXT_CTL_V_3
  

; Message at 26580
LOAD_MSG:
  DEFM "Load from:"
  DEFB $00


; Routine at 26591
;
; Used by the routines at TEL_UPLD_0, SCL_LFND, L6981 and GET_TXTEND.
TXT_BLOCK_SEL:
  XOR A
  LD (TXT_COUNT),A
  LD (TXT_BUFLAG),A
  LD HL,TXT_BUF
  LD (TXT_PTR),HL

TXT_BLOCK_SEL_LOOP:
  PUSH DE
  CALL TXT_BLOCK_SEL_SUB
  POP DE
  LD A,(DE)
  INC DE
  CP $1A		; EOF, CTRL/Z
  JP Z,TXT_CTLZ_EOF
  CP $0D         ; CR
  JP Z,TXTCURS_CR
  CP $09		; TAB
  JP Z,TXT_TAB
  CP ' '
  JP C,TXT_SPC
TXT_TAB:
  CALL TXT_ADD_GRAPH
  JP NC,TXT_BLOCK_SEL_LOOP
  LD A,(DE)
  CALL TXT_IS_SYMBOL
  JP NZ,TXT_CTL_V_6
  CALL TXT_BLOCK_SEL_END
  LD A,(DE)
  CP ' '
  RET NZ
  LD A,(TXT_EDITING)
  AND A
  RET Z
  INC DE
  LD A,(DE)
  CP ' '
  RET NZ
  DEC DE
  RET

TXT_CTL_V_6:
  EX DE,HL
  LD (PASTE_BUF),HL
  EX DE,HL
  LD HL,(TXT_PTR)
  LD (TXT_SAVPTR),HL
  DEC DE
  LD A,(DE)
  INC DE
  CALL TXT_IS_SYMBOL
  JP Z,TXT_BLOCK_SEL_END

TXT_CTL_V_7:
  DEC DE
  LD A,(DE)
  INC DE
  CALL TXT_IS_SYMBOL
  JP Z,TXT_CRLF
  DEC DE
  CALL TXT_CTL_V_17
  JP NZ,TXT_CTL_V_7
  LD HL,(TXT_SAVPTR)
  LD (TXT_PTR),HL
  LD HL,(PASTE_BUF)
  EX DE,HL

TXT_BLOCK_SEL_END:
  LD A,(TXT_EDITING)
  DEC A
  JP Z,TXT_CRLF_0
  RET

TXT_SPC:
  PUSH AF
  LD A,$5E		; '^'
  CALL TXT_ADD_GRAPH
  JP C,TXT_CTL_V_10
  POP AF
  OR $40
  CALL TXT_ADD_GRAPH
  JP NC,TXT_BLOCK_SEL_LOOP
  LD A,(TXT_EDITING)
  AND A
  JP NZ,TXT_CRLF_0
  RET

TXT_CTL_V_10:
  POP AF
  DEC DE
  LD HL,(TXT_PTR)
  DEC HL
  LD (TXT_PTR),HL
  LD HL,TXT_COUNT
  DEC (HL)
  JP TXT_CRLF

TXT_CTLZ_EOF:
  LD A,(TXT_EDITING)
  AND A
IF M10
  LD A,$AB	;  EOF Symbol in editor
ELSE
  LD A,$9B	;  EOF Symbol in editor (left arrow)
ENDIF
  CALL Z,TXT_ADD_GRAPH
  CALL TXT_CRLF
  LD DE,$FFFF
  RET

TXTCURS_CR:
  LD A,(DE)
  CP $0A         ; LF
  LD A,$0D       ; CR
  JP NZ,TXT_SPC
  PUSH DE
  CALL TXT_BLOCK_SEL_SUB
  POP DE
  LD A,(TXT_EDITING)
  AND A
IF M10
  LD A,$A0	;  CR Symbol in editor
ELSE
  LD A,$8F	;  CR Symbol in editor (black triangle)
ENDIF
  CALL Z,TXT_ADD_GRAPH
  CALL TXT_CRLF
  INC DE
  RET

; Control characters can be shown with special symbols
TXT_ADD_GRAPH:
  PUSH HL
  CALL ADD_CHAR
  LD HL,TXT_COUNT
  CP $09		; TAB
  JP Z,ADD_TAB
  INC (HL)
  JP ADD_TTYIST

ADD_TAB:
  INC (HL)
  LD A,(HL)
  AND $07
  JP NZ,ADD_TAB
ADD_TTYIST:
  LD A,(TRM_WIDTH)
  DEC A
  CP (HL)
  POP HL
  RET

ADD_CHAR:
  LD HL,(TXT_PTR)
  LD (HL),A
  INC HL
  LD (TXT_PTR),HL
  RET

TXT_CTL_V_17:
  LD HL,(TXT_PTR)
  DEC HL
  DEC HL
  DEC HL
  LD A,(HL)
  CP $1B		; ESC
  JP Z,TXT_CTL_V_18
  INC HL
  INC HL
TXT_CTL_V_18:
  LD (TXT_PTR),HL
  LD HL,TXT_COUNT
  DEC (HL)
  RET

TXT_CRLF:
  LD A,(TXT_COUNT)
  LD HL,TRM_WIDTH
  CP (HL)
  RET NC
  LD A,(TXT_EDITING)
  AND A
  JP NZ,TXT_CRLF_0
  LD A,$1B		; ESC ..
  CALL ADD_CHAR
  LD A,$4B		; ..'K', "erase in line"
  CALL ADD_CHAR
TXT_CRLF_0:
  LD A,$0D		; CR
  CALL ADD_CHAR
  LD A,$0A		; LF
  JP ADD_CHAR
  
TXT_BLOCK_SEL_SUB:
  CALL TXT_IS_SETFILING
  LD A,(TXT_EDITING)
  AND A
  RET NZ
  LD BC,TXT_BUFLAG
  PUSH DE
  EX DE,HL
  LD HL,(TXT_SEL_END)
  EX DE,HL
  RST CPDEHL
  POP DE
  JP NC,TXT_CTL_V_23
  EX DE,HL
  RST CPDEHL
  JP C,TEXT_NOREV
  EX DE,HL
  LD HL,(TXT_SEL_END)
  EX DE,HL
  RST CPDEHL
  JP NC,TEXT_NOREV

TEXT_REV:
  LD A,(BC)
  AND A
  RET NZ
  INC A
  LD H,'p'			; ESC p (enter in inverse video mode)
  JP ADD_ESC_SEQ
  
TXT_CTL_V_23:
  EX DE,HL
  RST CPDEHL
  JP NC,TEXT_NOREV
  EX DE,HL
  LD HL,(TXT_SEL_END)
  EX DE,HL
  RST CPDEHL
  JP NC,TEXT_REV

TEXT_NOREV:
  LD A,(BC)
  AND A
  RET Z
  XOR A
  LD H,'q'			; ESC q (exit from inverse video mode)
ADD_ESC_SEQ:
  PUSH HL
  LD (BC),A
  LD A,$1B		; ESC
  CALL ADD_CHAR
  POP AF
  JP ADD_CHAR

TXT_IS_SYMBOL:
  LD B,A
  LD A,(BASICMODE)
  AND A
  LD A,B
  RET Z
; This entry point is used by the routine at TXT_CTL_A.
TXT_CTL_V_27:
  LD HL,SYMBS_TXT
IF M10
  LD B,8
ELSE
  LD B,10
ENDIF
SYMB_LOOP:
  CP (HL)
  RET Z
  INC HL
  DEC B
  JP NZ,SYMB_LOOP
  CP '!'
  INC B
  RET NC
  DEC B
  RET

SYMBS_TXT:
IF M10
  DEFM "()<>+-*/"
  DEFB $00
  DEFB $00
ELSE
  DEFM "()<>[]+-*/"
ENDIF

; Used by the routines at TXT_CTL_N and TXT_CTL_V.
L6981:
  CALL GET_BOTTOMROW
  AND A
  RRA
; This entry point is used by the routines at WAIT_SPC and TXT_CTL_U.
TXT_CTL_V_29:
  CALL GET_TXTEND_1
  LD (EDTVARS+12),HL
  CALL GET_BOTTOMROW
  ADD A,A
  LD HL,EDTVARS+14
TXT_CTL_V_30:
  LD (HL),$FE
  INC HL
  DEC A
  JP NZ,TXT_CTL_V_30
  INC A
  JP TXT_CTL_V_34

; This entry point is used by the routine at TXT_CTL_H.
TXT_CTL_V_31:
  PUSH AF
  LD HL,(EDTVARS+10)
TXT_CTL_V_32:
  LD A,H
  OR L
  JP Z,TXT_CTL_V_33
  EX DE,HL
  CALL TXT_BLOCK_SEL
  POP AF
  LD B,A
  CALL TXT_CTL_V_43
  LD A,B
  PUSH AF
  JP Z,TXT_CTL_V_33
  DEC A
  JP Z,TXT_CTL_V_33
  LD L,A	; cursor coordinates
  LD H,$01	; cursor coordinates
  CALL POSIT
  CALL TXT_PRINTBLOCK		; Ouput text in the memory range between DE and HL
  LD A,D
  AND E
  INC A
  POP BC
  JP Z,ERAEOL
  PUSH BC
TXT_CTL_V_33:
  POP AF

; This entry point is used by the routines at TXT_CTL_Z, TXT_CTL_C, MCLEAR and
; MOVE_TEXT.
TXT_CTL_V_34:
  LD L,A	; cursor coordinates
  LD H,$01	; cursor coordinates
  CALL POSIT
  CALL TXT_CTL_V_47
  LD A,E
  AND D
  INC A
  JP Z,TXT_CTL_V_39
  CALL TXT_CTL_V_47
TXT_CTL_V_35:
  CALL GO_BOTTOMROW
  CP L
  JP Z,TXT_CTL_V_36
  CALL TXT_CTL_V_40
  LD A,D
  AND E
  INC A
  JP Z,TXT_CTL_V_38
  CALL TXT_CTL_V_44
  JP NZ,TXT_CTL_V_35
  RET

TXT_CTL_V_36:
  CALL TXT_CTL_V_40
TXT_CTL_V_37:
  CALL GET_BOTTOMROW
  INC A
  JP TXT_CTL_V_43

TXT_CTL_V_38:
  CALL TXT_CTL_V_44
  JP Z,TXT_CTL_V_37
TXT_CTL_V_39:
  CALL ERAEOL
  CALL CR_LF
  JP TXT_CTL_V_38

; This entry point is used by the routines at TXT_CTL_C and TXT_CTL_Y.
TXT_CTL_V_40:
  CALL TXT_BLOCK_SEL
; This entry point is used by the routine at SCL_LFND.
; Ouput text in the memory range between DE and HL
TXT_PRINTBLOCK:
  PUSH DE
  LD HL,(TXT_PTR)
  LD DE,TXT_BUF
TXT_CTL_V_42:
  LD A,(DE)
  RST OUTDO
  INC DE
  RST CPDEHL
  JP NZ,TXT_CTL_V_42
  LD A,(TXT_EDITING)
  AND A
  CALL Z,EXTREV		; Exit from reverse mode
  POP DE
  RET

TXT_CTL_V_43:
  PUSH DE
  CALL TXT_CTL_V_48
  JP TXT_CTL_V_45
TXT_CTL_V_44:
  PUSH DE
  CALL TXT_CTL_V_47
TXT_CTL_V_45:
  LD C,A
  EX (SP),HL
  RST CPDEHL
  LD A,C
  EX DE,HL
  POP HL
  RET Z
  LD (HL),E
  INC HL
  LD (HL),D
  LD A,C
  RET

; This entry point is used by the routines at TXT_CTL_Z, TXT_CTL_C, TXT_CTL_U
; and TXT_CTL_N.
TXT_CTL_V_46:
  CALL GET_BOTTOMROW
  INC A
  JP TXT_CTL_V_48

; This entry point is used by the routines at TXT_CTL_E, TXT_CTL_T, TXT_CTL_B,
; TXT_CTL_L and TXT_CTL_C.
TXT_CTL_V_47:
  LD A,(CSRX)
  
; This entry point is used by the routines at TXT_CTL_X, TXT_CTL_B and MCLEAR.
TXT_CTL_V_48:
  LD E,A
  LD D,$00
  LD HL,EDTVARS+10
  ADD HL,DE
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  DEC HL
  RET

; This entry point is used by the routine at TXT_CTL_C.
TXT_CTL_V_49:
  CALL TXT_CTL_V_47
  DEC A
  JP Z,GET_TXTSIZE
  DEC HL
  LD D,(HL)
  DEC HL
  LD E,(HL)
  RET

; This entry point is used by the routine at GET_TXTEND.
GET_TXTSIZE:
  LD HL,(CUR_TXTFILE)
  RST CPDEHL
  JP C,GET_TXTSIZE_SUB
  LD DE,$0000
  RET

GET_TXTSIZE_SUB:
  PUSH DE
  DEC DE
  RST CPDEHL
  JP NC,GET_TXTSIZE_SUB_1
GET_TXTSIZE_SUB_0:
  DEC DE
  RST CPDEHL
  JP NC,GET_TXTSIZE_SUB_1
  LD A,(DE)
  CP $0A         ; LF
  JP NZ,GET_TXTSIZE_SUB_0
  DEC DE
  RST CPDEHL
  JP NC,GET_TXTSIZE_SUB_1
  LD A,(DE)
  INC DE
  CP $0D         ; CR
  JP NZ,GET_TXTSIZE_SUB_0
  INC DE
GET_TXTSIZE_SUB_1:
  PUSH DE
  CALL TXT_BLOCK_SEL
  POP BC
  EX DE,HL
  POP DE
  PUSH DE
  RST CPDEHL
  EX DE,HL
  JP C,GET_TXTSIZE_SUB_1
  POP DE
  LD E,C
  LD D,B
  RET
  
; This entry point is used by the routines at TXT_CTL_I, TXT_CTL_M and
; TXT_CTL_H.
TXT_CTL_V_54:
  CALL TXT_CTL_V_49
  EX DE,HL
  LD (EDTVARS+10),HL
  RET
  
; This entry point is used by the routines at TXT_CTL_R and TXT_CTL_C.
TXT_CTL_V_55:
  LD (SAVE_CSRX),HL
  PUSH HL
  LD HL,EDTVARS+12
  CALL GET_BOTTOMROW
  LD B,A
TXT_CTL_V_56:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  PUSH HL
  LD HL,(SAVE_CSRX)
  RST CPDEHL
  JP C,TXT_CTL_V_57
  POP HL
  EX DE,HL
  EX (SP),HL
  EX DE,HL
  DEC B
  JP P,TXT_CTL_V_56
  DI
  HALT
  
TXT_CTL_V_57:
  EX DE,HL
  POP HL
  POP HL
TXT_CTL_V_58:
  PUSH HL
  LD HL,TXT_BUF
  LD (TXT_PTR),HL
  XOR A
  LD (TXT_COUNT),A
  POP HL
  DEC HL
TXT_CTL_V_59:
  INC HL
  RST CPDEHL
  JP NC,TXT_CTL_V_60
  LD A,(HL)
  CALL TXT_ADD_GRAPH
  LD A,(HL)
  CP ' '
  JP NC,TXT_CTL_V_59
  CP $09			; TAB
  JP Z,TXT_CTL_V_59
  CALL TXT_ADD_GRAPH
  JP TXT_CTL_V_59

TXT_CTL_V_60:
  LD A,(TXT_COUNT)
  INC A
  LD H,A
  CALL GET_BOTTOMROW
  SUB B
  LD L,A
  RET
  
; This entry point is used by the routines at TXT_CTL_I, TXT_CTL_M, TXT_CTL_H,
; TXT_CTL_F, TXT_CTL_A, TXT_CTL_R, TXT_CTL_L, TXT_CTL_C, TXT_CTL_U and
; TXT_CTL_N.
TXT_GET_CURPOS:
  CALL TXT_CTL_V_47
  PUSH DE
  INC A
  CALL TXT_CTL_V_48
  LD A,D
  AND E
  INC A
  JP NZ,TXT_GET_CURPOS_0
  LD HL,(TEXT_END)
  EX DE,HL
  INC DE
TXT_GET_CURPOS_0:
  DEC DE
  LD A,(DE)
  CP $0A         ; LF
  JP NZ,TXT_GET_CURPOS_1
  DEC DE
  LD A,(DE)
  CP $0D         ; CR
  JP Z,TXT_GET_CURPOS_1
  INC DE
TXT_GET_CURPOS_1:
  POP HL
  PUSH HL
  CALL TXT_CTL_V_58
  LD A,(CSRY)
  CP H
  JP C,TXT_GET_CURPOS_0
  POP HL
  EX DE,HL
  RET

; This entry point is used by the routines at WAIT_SPC and TXT_CTL_U.
GET_TXTEND_CURTXT:
  LD HL,(CUR_TXTFILE)

; Point HL to chr$(26)
;
; Used by the routines at DWNLDR and MCLEAR.
GET_TXTEND:
  LD A,$1A		; EOF
GET_TXTEND_0:
  CP (HL)
  INC HL
  JP NZ,GET_TXTEND_0
  DEC HL
  LD (TEXT_END),HL
  RET

; This entry point is used by the routines at TXT_CTL_Z and TXT_CTL_V.
GET_TXTEND_1:
  PUSH AF
  EX DE,HL
  LD HL,(CUR_TXTFILE)
  EX DE,HL
GET_TXTEND_2:
  PUSH HL
  PUSH DE
  CALL TXT_BLOCK_SEL
  POP BC
  POP HL
  RST CPDEHL
  JP NC,GET_TXTEND_2
  LD H,B
  LD L,C
  POP BC
  DEC B
  RET Z
  EX DE,HL
GET_TXTEND_3:
  PUSH BC
  CALL GET_TXTSIZE
  POP BC
  LD A,D
  OR E
  LD HL,(CUR_TXTFILE)
  RET Z
  DEC B
  JP NZ,GET_TXTEND_3
  EX DE,HL
  RET

; Insert a character in a file. A=char to insert, HL=address at which to
; insert, exit: HL++
;
; Used by the routine at MAKTXT.
INSCHR:
  LD BC,$0001
  PUSH AF
  CALL MAKHOL
  POP BC
  RET C
  LD (HL),B
  INC HL
  RET

; Insert a specified number of spaces in a file, BC = number, HL = address at
; which to insert, exit: CY if out of memory
;
; Used by the routines at RAM_INPUT, CSAVEM, __CLOAD, TXT_CTL_U and INSCHR.
MAKHOL:
  EX DE,HL
  LD HL,(STREND)
  ADD HL,BC
  RET C
  LD A,$88			; ?TK_GOTO?
  SUB L
  LD L,A
  LD A,$FF
  SBC A,H
  LD H,A
  RET C
  ADD HL,SP
  CCF
  RET C
; This entry point is used by the routines at RESFPT, TXT_CTL_C and TXT_CTL_U.
MAKHOL_0:
  PUSH BC
  CALL MASDEL_0		; Delete specified no of characters, BC=number, HL=address
  LD HL,(STREND)
  LD A,L
  SUB E
  LD E,A
  LD A,H
  SBC A,D
  LD D,A
  PUSH DE
  LD E,L
  LD D,H
  ADD HL,BC
  LD (STREND),HL
  EX DE,HL
  DEC DE
  DEC HL
  POP BC
  LD A,B
  OR C
  CALL NZ,_LDDR
  INC HL
  POP BC
  RET

; Delete specified no of characters, BC=number, HL=address
; Used by the routines at KILLASC, __NEW, SWAPNM, MCLEAR and TXT_CTL_U.
MASDEL:
  LD A,B
  OR C
  RET Z
  PUSH HL
  PUSH BC
  PUSH HL
  ADD HL,BC
  EX DE,HL
  LD HL,(STREND)
  EX DE,HL
  LD A,E
  SUB L
  LD C,A
  LD A,D
  SBC A,H
  LD B,A
  POP DE
  LD A,B
  OR C
  CALL NZ,_LDIR
  EX DE,HL
  LD (STREND),HL
  POP BC
  XOR A
  SUB C
  LD C,A
  SBC A,A
  SUB B
  LD B,A
  POP HL
; This entry point is used by the routine at MAKHOL.
MASDEL_0:
  PUSH HL
  LD HL,(CO_FILES)
  ADD HL,BC
  LD (CO_FILES),HL
  LD HL,(VARTAB)
  ADD HL,BC
  LD (VARTAB),HL
  LD HL,(VAREND)
  ADD HL,BC
  LD (VAREND),HL
  POP HL
  RET

; = LDIR
;
; Used by the routines at CSAVEM, CLOADM, LDIR_B, ESC_J, MCLEAR, TXT_CTL_U and
; MASDEL.
_LDIR:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC DE
  DEC BC
  LD A,B
  OR C
  JP NZ,_LDIR
  RET

; = LDDR
;
; Used by the routines at TXT_CTL_C, MCLEAR and MAKHOL.
_LDDR:
  LD A,(HL)
  LD (DE),A
  DEC HL
  DEC DE
  DEC BC
  LD A,B
  OR C
  JP NZ,_LDDR
  RET


; Start of ROM program catalog entries
;
;----------------
ROM_PROGS:
;----------------
  DEFB $B0
  DEFW BASIC
  DEFM "BASIC  "
  DEFB $00
  
  DEFB $B0
  DEFW TEXT
  DEFM "TEXT   "
  DEFB $00
  
  DEFB $B0
  DEFW TELCOM
  DEFM "TELCOM "
  DEFB $00

IF M100 | M10
  DEFB $B0
  DEFW ADDRSS
  DEFM "ADDRSS "
  DEFB $00
  
  DEFB $B0
  DEFW SCHEDL
  DEFM "SCHEDL "
  DEFB $00
ENDIF
  
  DEFB $88
  DEFW $0000
  DEFB $00
  DEFM "Suzuki "
  
  DEFB $C8
  DEFW $0000
  DEFB $00
  DEFM "Hayashi"
  
  DEFB $48
  DEFW $0000
  DEFB $00
  DEFM "RickY  "

;----------------
ROM_PROGS_END:
;----------------

IF KC85
  DEFS 22		;  space filler, probably left to re-introduce SCHEDL and ADDRSS if needed.
ENDIF


; Entry to BASIC   (6c4eh?)
BASIC:
  CALL BASIC_1
  CALL PRINT_COPYRIGHT
  LD HL,SUZUKI-1
  LD (DIRPNT),HL
  LD HL,(SUZUKI)
  LD (BASTXT),HL
; This entry point is used by the routine at __EDIT.
BASIC_0:
  CALL LOAD_BA_LBL
  CALL FNKSB
  XOR A
  LD (FNK_FLAG),A			; Enable top FN key row (incl. BREAK)
  INC A
  LD (LBL_LINE),A
  LD HL,LLIST_STMT		;"llist"
  LD (SHFT_PRINT),HL			; prepare the shortcut for SHIFT-PRINT
  CALL LINKER
  CALL RUN_FST
  JP READY

LLIST_STMT:
  DEFM "llist"
  DEFB $0D
  DEFB $00

; This entry point is used by the routine at __MENU.
BASIC_1:
  LD HL,(VARTAB)
  LD BC,$0178
  ADD HL,BC
  EX DE,HL
  LD HL,(MEMSIZ)
  RST CPDEHL
  JP C,BASIC_2
  DEC H
BASIC_2:
  LD (STKTOP),HL
  RET

; This entry point is used by the routines at OUTS_B_CHARS and BOOT.
SAVE_BA_LBL:
  LD HL,FNKSTR
  LD DE,IPLBBUF
  JP LOAD_BA_LBL_0

; LOAD BA LABEL
;
; Used by the routines at __MENU and BASIC.
LOAD_BA_LBL:
  LD HL,IPLBBUF
  LD DE,FNKSTR
; This entry point is used by the routine at BASIC.
LOAD_BA_LBL_0:
  LD B,$80		; 128
  JP LDIR_B
  
; This entry point is used by the routines at TELCOM_RDY and SCHEDL_DE.
PARSE_COMMAND:
  DEC HL
  RST CHRGTB		; Gets next character (or token) from BASIC text.
PARSE_COMMAND_0:
  LD A,(DE)
  INC A
  RET Z
  PUSH HL
  LD B,$04
PARSE_COMMAND_1:
  LD A,(DE)
  LD C,A
  CALL MAKUPL
  CP C
  INC DE
  INC HL
  JP NZ,PARSE_COMMAND_3
  DEC B
  JP NZ,PARSE_COMMAND_1
  POP AF
  PUSH HL
  EX DE,HL
; This entry point is used by the routine at IOINIT.
PARSE_COMMAND_2:
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  POP DE
  EX (SP),HL
  PUSH HL
  EX DE,HL
  INC H
  DEC H
  RET

PARSE_COMMAND_3:
  INC DE
  DEC B
  JP NZ,PARSE_COMMAND_3
PARSE_COMMAND_4:
  INC DE
  POP HL
  JP PARSE_COMMAND_0

; Cold start, Re-initialize system.  User files are not lost.
;
; Used by the routine at BOOT.
INITIO:
  DI
  LD HL,ENDLCD
IF M10
  LD B,97
ENDIF
IF KC85
  LD B,126
ENDIF
IF M100
  LD B,189			; (132 on PC8201, 126 ok KC85)
ENDIF
  CALL ZERO_MEM

IF M10
  LD A,$EC
  OUT ($BA),A
  IN A,($BB)
  RRCA
  RRCA
  RRCA
  RRCA
  AND $03
  LD (BRKCHR+1),A
  OR $FF
ELSE
  INC A
ENDIF

; Warm Start Reset
;
; Used by the routine at BOOT.
IOINIT:
  PUSH AF
  DI
  LD A,$19
IF M10
  JR NC,PARSE_COMMAND_4
ELSE
  JR NC,PARSE_COMMAND_2
ENDIF
  RET Z
  LD A,$43
  OUT ($B8),A
  LD A,$05
  CALL SET_CLOCK_HL_4
IF M10
  LD A,$E5
ELSE
  LD A,$ED
ENDIF
  OUT ($BA),A
  XOR A
  LD (ROMSEL),A
  OUT ($E8),A		; Page out the optional ROM

IF M100
  OUT ($A8),A
  CALL _CLICK_1
ENDIF

IF KC85 | M10
  LD (IOFLAGS+1),A
ENDIF

  CALL INIT_LCD_ADDR
  XOR A
  OUT ($FE),A
  CALL INIT_LCD_ADDR
  LD A,$3B
  OUT ($FE),A
  CALL LCD_INIT_3E
  CALL INIT_LCD_ADDR
  LD A,$39
  OUT ($FE),A		; Enable LCD
  EI
  CALL _CLICK_4
  JP NC,IOINIT_1
IOINIT_0:
  XOR A
IOINIT_1:
  LD (SEEDRD+7),A
  OR A
  JP Z,IOINIT_2
  LD A,(IOFLAGS+2)
  OR A
  JP NZ,IOINIT_2
  POP AF
  RET Z
  LD HL,(VARTAB)
  LD DE,$E000
  RST CPDEHL
  RET NC
  CALL _CLICK_5
  PUSH AF
  JP C,IOINIT_0
IOINIT_2:
  POP AF
  RET

; PRINTER: A = chr to print, CY if BREAK
;
; Used by the routine at LPT_OUT.
PRINTR:
  PUSH BC
  LD C,A
PRINTR_0:
  CALL BREAK
  JP C,L6D6A
  
  IN A,($BB)
  AND $06
  XOR $02
  JP NZ,PRINTR_0
  CALL SETINT_1D
  LD A,C
  OUT ($B9),A
  LD A,(ROMSEL)
  LD B,A
  OR $02
IF KC85 | M10
  DI
ENDIF
  OUT ($E8),A
  LD A,B
  OUT ($E8),A
  LD B,$24
PRINTR_1:
  DEC B
  JP NZ,PRINTR_1
IF KC85 | M10
  EI
ENDIF
  LD A,$09

  defb $30		; JR NC,N

; Used by the routine at PRINTR.
L6D6A:
  LD A,C
  POP BC
  RET

; Check RS232 queue for characters, Z if no data, A = number of chars in queue
;
; Used by the routines at NEWSTT, TEL_TERM, TEL_UPLD and RV232C.
RCVX:
  LD A,(XONXOFF_FLG)
  OR A
  JP Z,RCVX_0
  LD A,(XONXOFF)
  INC A
  RET Z
RCVX_0:
  LD A,(RS232_COUNT)
  OR A
  RET

; Get from RS232, A = char, Z if OK, CY if BREAK
;
; Used by the routines at COM_INPUT, TEL_LOGON, TEL_TERM and TEL_UPLD.
RV232C:
  PUSH HL
  PUSH DE
  PUSH BC
  LD HL,POPALL_INT+1
  PUSH HL
  LD HL,RS232_COUNT
RV232C_0:
  CALL BREAK
  RET C
  CALL RCVX
  JP Z,RV232C_0
  CP $03
  CALL C,SENDCQ
  DI
  DEC (HL)
  CALL _UART_2
  LD A,(HL)
  EX DE,HL
  INC HL
  INC HL
  INC (HL)
  DEC (HL)
  RET Z
  DEC (HL)
  JP Z,RV232C_1
  CP A
  RET
RV232C_1:
  OR $FF
  RET

; RST 6.5 (RS232 Interrupt on received character) routine
;
; Used by the routine at RST65.
_UART:
  CALL UART
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD HL,POPALL_INT
  PUSH HL
  IN A,($C8)
  LD HL,COMMSK
  AND (HL)
  LD C,A
  IN A,($D8)
  AND $0E
  LD B,A
  JP NZ,_UART_0
  LD A,C
  CP $11	; XON
  JP Z,L6DD1+1
  CP $13	; XOFF
  JP NZ,_UART_0
  
L6DD1:
  LD A,$AF
	; L6DD1+1:  XOR A

; Used by the routine at _UART.
  LD (ENDLCD),A
  LD A,(XONXOFF_FLG)
  OR A
  RET NZ

_UART_0:
  LD HL,RS232_COUNT
  LD A,(HL)
  CP $40	; 64 bytes max
  RET Z
  CP 40
; This entry point is used by the routine at PRINTR.
_UART_1:
  CALL NC,SENDCS
  PUSH BC
  INC (HL)
  INC HL
  CALL _UART_2
  POP BC
  LD (HL),C
  LD A,B
  OR A
  RET Z
  EX DE,HL
  INC HL
  DEC (HL)
  INC (HL)
  RET NZ
  LD A,(RS232_COUNT)
  LD (HL),A
  RET
  
; This entry point is used by the routine at RV232C.
_UART_2:
  INC HL
  LD C,(HL)
  LD A,C
  INC A
  AND $3F
  LD (HL),A
  EX DE,HL
  LD HL,RS232_BUF
  LD B,$00
  ADD HL,BC
  RET

; Send CTRL-Q character (X-ON)
;
; Used by the routine at RV232C.
SENDCQ:
  LD A,(XONXOFF_FLG)
  AND A
  RET Z
  LD A,(CTRL_S_FLG)
  DEC A
  RET NZ
  LD (CTRL_S_FLG),A
  PUSH BC
  LD C,$11	; XON
  JP _SD232C

; Send CTRL-S character (X-OFF)
;
; Used by the routine at _UART.
SENDCS:
  LD A,(XONXOFF_FLG)
  AND A
  RET Z
  LD A,(CTRL_S_FLG)
  OR A
  RET NZ
  INC A
  LD (CTRL_S_FLG),A
  PUSH BC
  LD C,$13		; XOFF
  JP _SD232C

; Send to RS232, A = char
;
; Used by the routines at COM_OUTPUT, TEL_LOGON, TEL_TERM and TEL_UPLD.
SD232C:
  PUSH BC
  LD C,A
  CALL _SD232C_1
  JP C,SD232C_END

; Send to RS232, A = char, no XON/XOFF
;
; Used by the routines at SENDCQ and SENDCS.
_SD232C:
IF M10
  IN A,($BA)
  LD B,A
ENDIF

__SD232C:
  CALL BREAK
IF M10
  JP C,_SD232C_0
ELSE
  JP C,SD232C_END
ENDIF
  IN A,($D8)
  AND $10
  JP Z,__SD232C

IF M10
  LD A,$7F
  AND B
  OUT ($BA),A
  IN A,($BB)
  AND $10
  JP NZ,__SD232C
ENDIF

  LD A,C
  OUT ($C8),A
  
; This entry point is used by the routine at SD232C.
IF M10
_SD232C_0:
  LD A,B
  OUT ($BA),A
ENDIF
SD232C_END:
  LD A,C
  POP BC
  RET

; This entry point is used by the routine at SD232C.
_SD232C_1:
  LD A,(XONXOFF_FLG)
  OR A
  RET Z
  LD A,C
  CP $11	; XON
  JP NZ,_SD232C_2
  XOR A
  LD (CTRL_S_FLG),A
  JP _SD232C_3

_SD232C_2:
  SUB $13	; XOFF
  JP NZ,_SD232C_4
  DEC A

_SD232C_3:
  LD (XONXOFF),A
  RET

_SD232C_4:
  CALL BREAK
  RET C
  LD A,(ENDLCD)
  OR A
  JP NZ,_SD232C_4
  RET

; Set baud rate, H = 0..9
;
; Used by the routine at INZCOM.
BAUDST:
  PUSH HL
  LD A,H
  RLCA
  LD HL,BAUD_TBL-2
  LD D,$00
  LD E,A
  ADD HL,DE
  LD (RS232_BAUD),HL
  POP HL
; This entry point is used by the routine at MUSIC.
BAUDST_0:
  PUSH HL
  LD HL,(RS232_BAUD)
  LD A,(HL)
  OUT ($BC),A
  INC HL
  LD A,(HL)
  OUT ($BD),A
  LD A,$C3
  OUT ($B8),A
  POP HL
  RET

; Start of 18 byte RS232 baud rate timer values (words).
BAUD_TBL:
  DEFW $4800
  DEFW $456B
  DEFW $4200
  DEFW $4100
  DEFW $4080
  DEFW $4040
  DEFW $4020
  DEFW $4010
  DEFW $4008

; Init RS232 and modem, H = 0..9 (baud rate), L = UART mode, CY if RS232,
; otherwise modem
;
; Used by the routine at SETSER.
INZCOM:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD B,$25

IF M100 | M10
  JP C,INZCOM_0
  LD H,$03
  LD B,$2D
INZCOM_0:
ENDIF

  DI
  CALL BAUDST
  LD A,B
  OUT ($BA),A
  IN A,($D8)
  LD A,L
  AND $1F
  OUT ($D8),A
  CALL RES_RS232_FLAGS
  DEC A			; $FF
  LD (RS232_FLG),A
  JP POPALL_INT


IF M100
; Deactivate RS232C/modem
;
; Used by the routines at COM_CLS, TEL_SET_STAT, TEL_BYE and __MENU.
CLSCOM:
  IN A,($BA)
  OR $C0
  OUT ($BA),A
  XOR A
  LD (RS232_FLG),A
  RET

; This entry point is used by the routine at CARDET.
CLSCOM_0:
  LD E,$00
CLSCOM_1:
  IN A,($D8)
  AND $01
  XOR D
  JP NZ,CLICK
  INC E
  JP P,CLSCOM_1
; This entry point is used by the routine at BAUD_TBL.
CLSCOM_2:
  RET

; Click sound port if sound is enabled
;
; Used by the routine at CLSCOM.
CLICK:
  PUSH AF
  LD A,(SOUND_FLG)
  OR A
  CALL Z,_CLICK
  POP AF
  RET

; Detect modem carrier, Z if detected. A=0 if detected, A=FF and no Z
; otherwise.
;
; Used by the routine at TEL_LIFT.
CARDET:
  PUSH HL
  PUSH DE
  PUSH BC
  LD HL,L6F2C
  PUSH HL
  IN A,($BB)
  AND $10
  LD HL,$0249		; const
  LD BC,$1A0E		; const
  JP NZ,CARDET_0
  LD HL,$0427		; const
  LD BC,$0C07		; const
CARDET_0:
  DI
  IN A,($D8)
  AND $01
  LD D,A
  CALL CLSCOM_0
  JP M,CARDET_1
  XOR D
  LD D,A
  CALL CLSCOM_0
CARDET_1:
  EI
  RET M
  LD A,E
  CP B
  RET NC
  CP C
  RET C
  DEC HL
  LD A,H
  OR L
  JP NZ,CARDET_0
  CALL RES_RS232_FLAGS
  POP HL
  ;JP NZ,GFX_TEMP
  defb $C2	; JP NZ,NN (always false)
  
; Routine at 28460
L6F2C:
  OR $FF
  JP POPALL_0
ENDIF


; Enable/disable XON/XOFFs when control Ss and Qs are sent
;
; Used by the routine at SETSER.
;_XONXOFF_FLG-1:		(enable)
DEFB $3E  ; "LD A,n" to Mask the next byte

_XONXOFF_FLG:		;   (disable)
  XOR A  ;($6F32)
  DI
  LD (XONXOFF_FLG),A
  EI
  RET

; This entry point is used by the routines at INZCOM and CARDET.
RES_RS232_FLAGS:
  XOR A
  LD L,A
  LD H,A
  LD (ENDLCD),HL
  LD (RS232_COUNT),HL
  LD (RS232_COUNT+2),HL
IF KC85 | M10
  LD (CTRL_S_FLG),A
ENDIF
  RET

IF KC85 | M10
; Deactivate RS232C/modem
; Same on M100 but in a different location
; Used by the routines at COM_CLS, TEL_SET_STAT, TEL_BYE and __MENU.
CLSCOM:
  IN A,($BA)
  OR $C0
  OUT ($BA),A
  XOR A
  LD (RS232_FLG),A
  RET
ENDIF

; Write cassette header and sync byte only
;
; Used by the routine at IO_ERR.
SYNCW:
  LD BC,$0200
SYNCW_0:
  LD A,$55
  PUSH BC
  CALL DATAW_0
  POP BC
  DEC BC
  LD A,B
  OR C
  JP NZ,SYNCW_0
  LD A,$7F
  JP DATAW_0

; Write char in A to cassette (no chksum)
;
; Used by the routine at CSOUT.
DATAW:
  CALL DATAW_3
; This entry point is used by the routine at SYNCW.
DATAW_0:
  LD B,$08
DATAW_1:
  CALL DATAW_2
  DEC B
  JP NZ,DATAW_1
  JP BREAK

DATAW_2:
  RLCA
  LD DE,$1F24		; timing constants
  JP C,DATAW_4
DATAW_3:
  LD DE,$4349		; timing constants
DATAW_4:
  DEC D
  JP NZ,DATAW_4
  LD D,A
  LD A,$D0		; CO type?
  
  ;JR NC,SYNCR_1
  defb $30		; JR NC,N

; Routine at 28540
L6F7C:
  DEC E
  JP NZ,L6F7C
  LD A,$50
  JR NC,CASS_PROBE_4
  RET

; Read cassette header and sync byte only
;
; Used by the routine at HEADER.
SYNCR:
  LD B,$80
SYNCR_0:
  CALL CASS_PROBE
  RET C
  LD A,C
IF M10
  CP $02
ELSE
  CP $08
ENDIF
  JP C,SYNCR
  CP $40
  JP NC,SYNCR
  DEC B
  JP NZ,SYNCR_0
; This entry point is used by the routine at DATAW.
SYNCR_1:
  CALL BREAK
  RET C
  LD HL,$0000
  LD B,$40
SYNCR_2:
  CALL CASS_PROBE_9
  RET C
  LD D,C
  CALL CASS_PROBE_9
  RET C
  LD A,D
  SUB C
  JP NC,SYNCR_3
  CPL
  INC A
SYNCR_3:
  CP $0B			; HOME
  JP C,L6FBA
  INC H

;  LD A,','
  DEFB $3E  ; "LD A,n" to Mask the next byte

; Routine at 28602
;
; Used by the routine at SYNCR.
L6FBA:
  INC L
  DEC B
  JP NZ,SYNCR_2
  LD A,$40
  CP L
  JP Z,SYNCR_4
  SUB H
  JP NZ,SYNCR_1
SYNCR_4:
  LD (CASS_HILO),A
  LD D,$00
SYNCR_5:
  CALL CASS_PROBE
  RET C
  CALL CASS_PROBE_10
  CP $7F		; BS
  JP NZ,SYNCR_5
  RET

; Find the frequency of the cassette port.
;
; Used by the routines at SYNCR and DATAR.
CASS_PROBE:
  LD C,$00
  LD A,(CASS_HILO)
  AND A
  JP Z,CASS_PROBE_3
CASS_PROBE_0:
  CALL BREAK
  RET C
  JR NZ,L6FEF + 2		;L6FF1
  JP NC,CASS_PROBE_0
CASS_PROBE_1:
  INC C
CASS_PROBE_2:
  INC C
L6FEF:
  JP Z,CASS_PROBE_0

; Routine at 28657
;
; Used by the routine at CASS_PROBE.
;L6FF1:
;  LD L,A

  ;JR NZ,$6FFB
  JR NZ,CASS_PROBE_3 + 1
  JP C,CASS_PROBE_2
  JP CASS_PROBE_7
CASS_PROBE_3:
;L6FFB (CASS_PROBE_3 + 1):
;  SBC A,A
;  LD (HL),D
  CALL BREAK
  RET C
; This entry point is used by the routine at DATAW.
CASS_PROBE_4:
  JR NZ,CASS_PROBE_6 + 3 ;$7007
  JP C,CASS_PROBE_3
CASS_PROBE_5:
  INC C
CASS_PROBE_6:
  INC C
  JP Z,CASS_PROBE_3
; L7007:
;  LD L,A
  JR NZ,CASS_PROBE_8
  JP NC,CASS_PROBE_6
CASS_PROBE_7:
  LD A,(SOUND_FLG)
  AND A
CASS_PROBE_8:
  CALL Z,_CLICK
  XOR A
  RET
  
; This entry point is used by the routine at SYNCR.
CASS_PROBE_9:
  CALL CASS_PROBE_5
  RET C
  LD C,$00
  CALL CASS_PROBE_1
  RET C
  JP CASS_PROBE_5
; This entry point is used by the routines at SYNCR and DATAR.
CASS_PROBE_10:
  LD A,C
IF M10
  CP $16
ELSE
  CP $15
ENDIF
  LD A,D
  RLA
  LD D,A
  RET

; Read char from cassette in D (no chksum)
;
; Used by the routine at CASIN.
DATAR:
  CALL CASS_PROBE
  RET C
  LD A,C
IF M10
  CP $16
ELSE
  CP $15
ENDIF
  JP C,DATAR
  LD B,$08
DATAR_0:
  CALL CASS_PROBE
  RET C
  CALL CASS_PROBE_10
  DEC B
  JP NZ,DATAR_0
  XOR A
  RET



; This entry point is used by the routines at CTOFF and MOTOR_OFF.
DATAR_1:
  LD A,(ROMSEL)
  AND $F1
  INC E
  DEC E
  JP Z,DATAR_2
  OR $08
DATAR_2:
  OUT ($E8),A
  LD (ROMSEL),A
  RET
  
; Routine at 28757
L7055:
  LD HL,_RST75_END
  PUSH HL
  LD HL,KBSITP
  DEC (HL)
  RET NZ
  LD (HL),$03
IF M10
  LD HL,KYDATA+9
ELSE
  LD HL,KYDATA+8
ENDIF
  LD DE,KB_SHIFT
  CALL BRK_SCAN

IF KC85 | M10
  LD C,A
  LD A,B
  OR $01
  OUT ($BA),A
  LD A,C
ENDIF
  
  CPL
  CP (HL)
  LD (HL),A
  CALL Z,DATAR_11

IF M10
  LD A,C
  OR $FC
  LD C,A
ENDIF

  XOR A
  OUT ($B9),A
  IN A,($E8)
  
IF M10
  XOR C
ELSE
  INC A
ENDIF

  LD A,$FF
  OUT ($B9),A
  JP Z,POPALL_INT_0

IF M10
  LD B,$FE
  LD A,C
  LD C,$08
  JP _DATAR_4
ELSE
  LD A,$7F
  LD C,$07
ENDIF

DATAR_3:
IF M100
  DEC HL
  DEC DE
ENDIF

  LD B,A
  OUT ($B9),A
  IN A,($E8)
  
_DATAR_4:
  CPL
IF KC85 | M10
  DEC HL
  DEC DE
ENDIF
  CP (HL)
  LD (HL),A
  
IF KC85 | M10
  LD A,$FF
  OUT ($B9),A
ENDIF
  
  JP NZ,DATAR_4
  LD A,(DE)
  CP (HL)
  CALL NZ,DATAR_5
DATAR_4:

IF M100
  LD A,$FF
  OUT ($B9),A
ENDIF

  LD A,B
  RRCA
  DEC C
  JP P,DATAR_3
  DEC HL
  LD (HL),$02
  LD HL,KYWHAT
  DEC (HL)
  JP Z,DATAR_12
  INC (HL)
  RET M
  LD A,(KYWHAT+2)
  LD HL,(KYWHAT+3)
  AND (HL)
  RET Z
  LD A,(KYBCNT)
  CP $02
  RET NC
  LD HL,KYREPT		; a.k.a. SCNCNT on MSX, wait count for repeat
  DEC (HL)
  RET NZ
  LD (HL),$06
  LD A,$01
  LD (CSRCNT),A		; Set time til next cursor blink
  JP DATAR_13

DATAR_5:
  PUSH BC
  PUSH HL
  PUSH DE
  LD B,A
  LD A,$80
  LD E,$07
DATAR_6:
  LD D,A
  AND (HL)
  JP Z,DATAR_7
  AND B
  JP Z,DATAR_9
DATAR_7:
  LD A,D
  RRCA
  DEC E
  JP P,DATAR_6
  POP DE
DATAR_8:
  POP HL
  LD A,(HL)
  LD (DE),A
  POP BC
  RET

DATAR_9:
  LD HL,KYWHAT
  INC A
  CP (HL)
  JP NZ,DATAR_10
  POP DE
  POP HL
  POP BC
  RET

DATAR_10:
  LD (HL),A
  LD A,C
  RLCA
  RLCA
  RLCA
  OR E
  INC HL
  LD (HL),A
  INC HL
  LD (HL),D
  POP DE
  EX DE,HL
  LD (KYWHAT+3),HL
  EX DE,HL
  JP DATAR_8
  
DATAR_11:
  LD A,(DE)
  LD B,A
  LD A,(HL)
  LD (DE),A
  RLCA
  RET NC
  LD A,B
  RLCA
  RET C
  EX (SP),HL
  LD HL,L71C4
  EX (SP),HL
IF M10
  LD D,$00
  LD A,(HL)
  AND 4
  LD A,$03
  RET NZ
ELSE
  LD B,$00
  LD D,B
  LD A,(HL)
  RRCA
  LD A,$03
  RET C
ENDIF
  LD A,$13	; XOFF ?
  RET

DATAR_12:
  DEC HL
  LD (HL),$54	; 'T'
  DEC HL
  LD A,(KB_SHIFT)
IF M10
  AND $FC
ENDIF
  LD (HL),A
DATAR_13:
  LD A,(KYWHAT+1)
  LD C,A
IF M10
  LD DE,$2F		; '/' 
ELSE
  LD DE,$2C		; ','
ENDIF
  LD B,D
IF M10
  CP $36		; '6'
ELSE
  CP $33		; '3'
ENDIF
  JP C,DATAR_14
  LD HL,KYWHAT+2
  LD (HL),B
DATAR_14:
  LD A,(KYHOW)
  RRCA

IF M10
  RRCA
  RRCA
ENDIF

  PUSH AF
  LD A,C
  CP E
  JP C,DATAR_18
  
IF M10
  JP Z,DATAR_15
  CP $34		; '4'
ELSE
  CP $30		; '0'
ENDIF

  JP NC,DATAR_15
  POP AF
  PUSH AF
  RRCA
  JP C,DATAR_18
DATAR_15:
  LD HL,KMAP1
  POP AF
  JP NC,DATAR_16
  LD HL,KMAP2
DATAR_16:
  ADD HL,BC
  LD A,(HL)

IF M100 | KC85
  RLCA
  OR A
  RRA
  LD C,A
  JP NC,DATAR_26
  CP $08
ENDIF

IF M10
  LD C,A
  CP $80
  JP C,DATAR_17
  CP $88				;  ?TK_GOTO?  ..?"Suzuki "?
ENDIF
  
  JP NC,DATAR_17
  LD A,(FNK_FLAG)
  AND $E0
  JP NZ,DATAR_17
  LD HL,(CURLIN)
  LD A,H
  AND L
  INC A
  JP Z,DATAR_17
  
IF M10
  LD HL,FNKSTAT-128
ELSE
  LD HL,FNKSTAT
ENDIF

  ADD HL,BC
  LD A,(HL)
  OR A
  JP Z,DATAR_17
  LD A,C
IF M100 | KC85
  OR $80
ENDIF
  JP DATAR_25

IF M100 | KC85
DATAR_17:
  DEC B
  JP DATAR_26
ENDIF
  
DATAR_18:
  POP AF
  
IF M100 | KC85
  JP C,DATAR_19
  LD E,B
DATAR_19:
  RRCA
  PUSH AF
  JP C,POPALL_INT_1
ELSE
  PUSH AF
  AND $88
  JP NZ,DATAR_20
  LD E,$00
ENDIF
  
; This entry point is used by the routine at POPALL_INT.
DATAR_20:
IF M10
  POP AF
  RRCA
  PUSH AF
  JP C,POPALL_INT_1
ELSE
  LD HL,L7C49
  RRCA
  JP C,DATAR_22
ENDIF
  
  LD HL,KMAP3
  RRCA
IF M10
  JP C,DATAR_22B
ELSE
  JP C,DATAR_22
ENDIF
  RRCA
  
IF M10
  LD A,C
ENDIF
  
  JP NC,DATAR_21

IF M10

  LD HL,L79AD
  LD B,12
_DATAR_20:
  CP (HL)
  INC HL
  JP Z,DATAR_24
  INC HL
  DEC B
  JP NZ,_DATAR_20
  POP AF
  RET

ELSE

  LD HL,KBDMAP_LCASE
  ADD HL,BC
  PUSH DE
  LD D,A
  CALL POPALL_INT_5
  LD A,D
  POP DE
  JP Z,DATAR_24

ENDIF

DATAR_21:

IF M10

  LD HL,KMAP1
  CP $1B
IF M10
  JP NC,DATAR_22B
ELSE
  JP NC,DATAR_22
ENDIF
  LD A,E
  RRCA
  LD A,(BRKCHR+1)
  RLA
  LD DE,$001B
  LD HL,KMAP0
  
ELSE

  RRCA
  CALL C,POPALL_INT_4
  LD HL,KBDMAP_LCASE 

ENDIF

DATAR_22:
  ADD HL,DE

IF M10

  DEC A
  JP P,DATAR_22
  ;LD A,$19
  DEFB $3E  ; "LD A,n" to Mask the next byte
 DATAR_22B:
  ADD HL,DE
ENDIF

; This entry point is used by the routine at POPALL_INT.
DATAR_23:
  ADD HL,BC

; This entry point is used by the routine at POPALL_INT.
DATAR_24:
  POP AF
  LD A,(HL)
  JP NC,L71C2
IF M10
  CP $5B
ELSE
  CP $60		; '
ENDIF
  RET NC

IF M10  
  CP $40
  RET C
ENDIF
  
  AND $3F

IF M100 | KC85
;  JP C,$C8B7
  defb $da		; JP C,NN
ENDIF

L71C2:
IF M100 | KC85
  OR A
  RET Z
ENDIF

; Routine at 29124
L71C4:
  LD C,A
  AND $EF
  CP $03
  JP NZ,DATAR_26
  LD A,(FNK_FLAG)
  AND $C0
  JP NZ,DATAR_26
  LD A,C
DATAR_25:
  LD (BRKCHR),A
  CP $03
  RET NZ
  LD HL,KYBCNT
  LD (HL),$01
  INC HL
  JP DATAR_27

IF M10
DATAR_17:
ENDIF
DATAR_26:
  LD HL,KYBCNT
  LD A,(HL)
  
  ; CP ' '
  defb $fe		; CP NN

; Routine at 29161
L71E9:
  defb $20	; JR NZ,NN
  
IF M100
  RET Z
ELSE
  RET NC
ENDIF

  INC (HL)
IF M100 | KC85
  RLCA
ENDIF
  INC HL
  LD E,A
  ADD HL,DE

DATAR_27:
  LD (HL),C
  
IF M100 | KC85
  INC HL
  LD (HL),B
ENDIF

  POP AF

; This entry point is used by the routine at SET_CLOCK_HL.
_RST75_END:
  LD A,$09
  
  ; THIS IS A COMPLEX OPTIMIZATION,
  ; THE RELATIVE JP OFFSET IS EQUIVALENT TO "POP AF" !
  ;
  ; Moving the code in this ROM is not definitely a beginner's task..
  ;
  ;JR NC,L71E9
  defb $30		; JR NC,N

; POP AF, BC, DE, and HL off stack, enable interrupts and return.
;
; Used by the routines at INZCOM and MUSIC.
POPALL_INT:
  POP AF	; --> used also as a relative offset (negative) to reach L71E9
;
  POP BC
  POP DE
  POP HL
  EI
  RET
  
; This entry point is used by the routine at DATAR.
POPALL_INT_0:
  LD HL,REPCNT
  DEC (HL)
  RET NZ
  LD HL,KYDATA
IF M10
  LD B,$13
ELSE
  LD B,$11
ENDIF
  JP ZERO_MEM

IF M10

POPALL_INT_1:
  LD E,$2F		; ..hides a "CPL" instruction ?
  LD A,C
  LD HL,L7971
  CP $0D
  JP Z,POPALL_INT_2
  LD HL,L7952
  CP $2F
  JP C,DATAR_21
POPALL_INT_2:
  POP AF
  ADD HL,BC
  LD A,(HL)
  JP L71C4
  
ELSE

; This entry point is used by the routine at DATAR.
POPALL_INT_1:
  LD A,C
  CP $1A		; EOF
  LD HL,KBDMAP_UCASE
  JP C,DATAR_23
  CP ','
  JP C,POPALL_INT_2
  CP '0'
  JP C,POPALL_INT_3
POPALL_INT_2:
  POP AF
  PUSH AF
  JP DATAR_20
  
POPALL_INT_3:
  SUB ','
  LD HL,L7D2F	; "QRWZ"
  LD C,A
  ADD HL,BC
  JP DATAR_24
  
ENDIF


IF M100 | KC85

; This entry point is used by the routine at DATAR.
POPALL_INT_4:
  LD A,C
  CP $1A
  RET NC
  LD E,$2C		; ','
  RET

; This entry point is used by the routine at DATAR.
POPALL_INT_5:
  LD A,(HL)
  LD E,$06
  LD HL,L7CF9
POPALL_INT_6:
  CP (HL)
  INC HL
  RET Z
  INC HL
  DEC E
  JP P,POPALL_INT_6
  RET

ENDIF



; A = Character (if any), Z if no key.  CY if special keys
;     When CY is set, A=0..7 for F1..F8, 8=LABEL, 9=PRINT, $0A=SH-PRINT, $0B=PASTE
;
; Used by the routine at CHGET.
KYREAD:
  CALL SETINT_1D
  LD A,(KYBCNT)
  OR A
  JP Z,EI_NORM
IF M10
  LD HL,KYRDBF
ELSE
  LD HL,KYRDBF+1
ENDIF
  LD A,(HL)
  
IF M10
  AND $E0
  XOR $80
  LD A,(HL)
  JP NZ,TXT_CTL_I_199
  AND $7F
  SCF
TXT_CTL_I_199:
  PUSH AF
  DEC HL
  DEC (HL)
  LD C,(HL)
ELSE
  ADD A,$02
  DEC HL
  LD A,(HL)
  PUSH AF
  DEC HL
  DEC (HL)
  LD A,(HL)
  RLCA
  LD C,A
ENDIF
  
IF M100
  INC HL
  LD DE,KYRDBF+2
ENDIF
IF KC85
  LD DE,KYRDBF+2
  INC HL
ENDIF
IF M10
  LD DE,KYRDBF+1
  INC HL
ENDIF

;BASIC_ALIGN:
;  DEFS $725E-BASIC_ALIGN


KYREAD_0:
  DEC C
IF KC85 | M10
L6F0A:
ENDIF


; Routine at 29280
; *** UNMOVABLE CODE on M100 !! ***
; Used by the routine at EI_NORM.
IF M100
  defb $FA  ; JP M,KYREAD_1+1
L7260:
  LD L,C		; $69
  LD (HL),D		; $72
ENDIF
IF KC85
  JP M,KYREAD_1+1	; skip 'PUSH AF'
ENDIF
IF M10
  JP M,KYREAD_1+1	; skip 'PUSH AF'
ENDIF



  LD A,(DE)
  LD (HL),A
  INC HL
  INC DE
  JP KYREAD_0

KYREAD_1:
IF M100
  POP AF
ENDIF

; Enable interrupts as normal (nothing destroyed)
;
; Used by the routine at KYREAD.
EI_NORM:
  PUSH AF
  LD A,$09
IF M100
  JR NC,L7260		; This slightly 'protects' the ROM
ENDIF
IF KC85 | M10
  JR NC,L6F0A
ENDIF
  RET

  

; Z if keyboard queue is empty, CY if BREAK
;
; Used by the routine at CHGET.
KEYX:
  CALL BRKCHK
  JP Z,KEYX_0
  CP $03
  JP NZ,KEYX_0
  OR A
  SCF
  RET

KEYX_0:
  LD A,(KYBCNT)
  OR A
  RET


; Test for CRTL-C or CRTL-S (pause), CY set in both the cases
;
; Used by the routines at CHSNS and KEYX.
BRKCHK:
  PUSH HL
  LD HL,BRKCHR
  LD A,(HL)
  LD (HL),$00
  POP HL
  OR A
  RET P
  PUSH HL
  PUSH BC
  LD HL,TRPTBL-(126*3)	; $F7CA (
  LD C,A
  LD B,$00
  ADD HL,BC
  ADD HL,BC
  ADD HL,BC
  CALL TRAPCHK
  POP BC
  POP HL
  XOR A
  RET

; Routine at 29343
;
; Used by the routines at TEL_LIFT, TEL_LOGON, TEL_TERM, PRINTR, RV232C,
; _SD232C, DATAW, SYNCR, CASS_PROBE, MUSIC and _CLICK.
BREAK:
  PUSH BC
  IN A,($B9)	; save value in porte $B9
  LD C,A
  CALL BRK_SCAN
IF M100
  PUSH AF
ENDIF
IF KC85 | M10
  LD B,A
ENDIF
  LD A,C
  OUT ($B9),A	; restore value in porte $B9
IF M100
  POP AF
ENDIF
IF KC85 | M10
  LD A,B
ENDIF
  POP BC
IF M10
  AND $84
ELSE
  AND $81
ENDIF
  RET NZ
  SCF
  RET

; Scan BREAK, CAPS, NUM, CODE, GRAPH, CONTROL, and SHIFT key column of
; keyboard.
;
; Used by the routines at DATAR and BREAK.
BRK_SCAN:
  LD A,$FF
  OUT ($B9),A
  IN A,($BA)
IF M100
  AND $FE
ENDIF
  LD B,A
IF KC85 | M10
  AND $FE
ENDIF
  OUT ($BA),A
  IN A,($E8)
  PUSH AF
  LD A,B
IF M100
  INC A
ENDIF
  OUT ($BA),A
  POP AF
  RET

; Make tone, DE=freq, B=duration
;
; Used by the routine at __SOUND.
; DE=frequency (must be < $C000), B=duration, (1..256)
MUSIC:
  DI
  LD A,E
  OUT ($BC),A
  LD A,D
  OR $40
  OUT ($BD),A
  LD A,$C3
  OUT ($B8),A
  IN A,($BA)
  AND $F8
  OR $20
  OUT ($BA),A
MUSIC_0:
  CALL BREAK
  JP NC,MUSIC_1
  LD A,$03
  LD (BRKCHR),A
  JP MUSIC_3

MUSIC_1:
  LD C,$64
MUSIC_2:
  PUSH BC
  LD C,$1E
  CALL DELAY_C
  POP BC
  DEC C
  JP NZ,MUSIC_2
  DEC B
  JP NZ,MUSIC_0
MUSIC_3:
  IN A,($BA)
  OR $04
  OUT ($BA),A
  CALL BAUDST_0
  EI
  RET
  
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  LD A,(HL)
  OUT ($70),A
  DI
  INC HL
  LD A,(HL)
  OUT ($71),A
  INC HL
  LD A,(HL)
  OUT ($72),A

MUSIC_4:
  LD A,B
  OR C
  JP Z,POPALL_INT
  IN A,($73)
  LD (DE),A
  INC DE
  DEC BC
  JP MUSIC_4

; Load the contents of the clock chip registers into the address pointed to by
; HL.
;
; Used by the routines at READ_CLOCK and _RST75.
READ_CLOCK_HL:
  defb $f6		; OR $AF

; Update the clock chip internal registers with the time in the buffer pointed
; to by HL
;
; Used by the routines at SET_CLOCK and BOOT.
SET_CLOCK_HL:
  XOR A
  PUSH AF
  CALL SETINT_1D
  LD A,$03
  CALL NZ,SET_CLOCK_HL_4
  LD A,$01
  CALL SET_CLOCK_HL_4
  LD C,$07
  CALL DELAY_C
  LD B,$0A
SET_CLOCK_HL_0:
  LD C,$04
  LD D,(HL)
SET_CLOCK_HL_1:
  POP AF
  PUSH AF
  JP Z,SET_CLOCK_HL_2
  IN A,($BB)
  RRA
  LD A,D
  RRA
  LD D,A
  XOR A
  JP SET_CLOCK_HL_3
  
SET_CLOCK_HL_2:
  LD A,D
  RRCA
  LD D,A
  LD A,$10
  RRA
  RRA
  RRA
  RRA
  OUT ($B9),A
SET_CLOCK_HL_3:
  OR $09
  OUT ($B9),A
  AND $F7
  OUT ($B9),A
  DEC C
  JP NZ,SET_CLOCK_HL_1
  LD A,D
  RRCA
  RRCA
  RRCA
  RRCA
  AND $0F
  LD (HL),A
  INC HL
  DEC B
  JP NZ,SET_CLOCK_HL_0
  POP AF
  LD A,$02
  CALL Z,SET_CLOCK_HL_4
  XOR A
  CALL SET_CLOCK_HL_4
  JP SET_CLOCK_HL_16
  
; This entry point is used by the routine at IOINIT.
SET_CLOCK_HL_4:
  OUT ($B9),A
  LD A,(ROMSEL)
  OR $04
  OUT ($E8),A
  AND $FB
  OUT ($E8),A
  RET
  
; This entry point is used by the routine at _RST75.
_RST75_7:
  CALL SETINT_1D
  LD HL,L7055
  PUSH HL
  LD HL,CSRCNT		; Time til next cursor blink
  DEC (HL)
  RET NZ
  LD (HL),$7D
  DEC HL
  LD A,(HL)
  OR A
  JP P,_RST75_8
  RET PO
_RST75_8:
  XOR $01
  LD (HL),A
  
; This entry point is used by the routines at ESC_J and DOTTED_FNAME.
PUT_SHAPE:
  PUSH HL
  LD HL,SHAPE
  LD D,$00
  CALL LOAD_SHAPE
  LD B,$06
  DEC HL
PUT_SHAPE_0:
  LD A,(HL)
  CPL
  LD (HL),A
  DEC HL
  DEC B
  JP NZ,PUT_SHAPE_0
  INC HL
  LD D,$01
  CALL LOAD_SHAPE
  POP HL
  RET
  

; This entry point is used by the routines at OUTC_SUB, ESC_Q, ESC_J and
; DOTTED_FNAME.
ESC_NOCURSOR:
  PUSH HL
  PUSH DE
  PUSH BC
  PUSH AF
  CALL SETINT_1D

; Routine at 29644
L73CC:
  LD HL,CSRSTS
  LD A,(HL)
  RRCA
  CALL C,PUT_SHAPE
  LD (HL),$80
  JP _RST75_END
  
; This entry point is used by the routines at OUTC_SUB and ESC_P.
ESC_CURSOR:
  PUSH AF
  PUSH HL
  CALL SETINT_1D
  LD HL,CSRSTS
  LD A,(HL)
  AND $7F
  LD (HL),A
  INC HL
  LD (HL),$01
  LD A,$09
  JR NC,L73CC+1
  POP AF
  RET


; This entry point is used by the routine at ESC_J.
DRAW_CHAR:
IF M10
  LD A,C
  CP $80
  JP C,_DRAW_CHAR
  CP $A0
  JP NC,_DRAW_CHAR
  LD C,$20
_DRAW_CHAR:
ENDIF

  CALL SETINT_1D
  LD HL,$0000
  ADD HL,SP
  LD (SAVSP),HL
  DEC D
  DEC E
  EX DE,HL
  LD (LCD_ADDR),HL
  LD A,C

IF M10
  LD HL,ASCII_SYM
  LD B,10
_DRAW_CHAR_0:
  CP (HL)
  JP Z,L714A		; M10 only
  INC HL
  DEC B
  JP NZ,_DRAW_CHAR_0
_DRAW_CHAR_1:
ENDIF

  LD DE,FONT-1
  SUB $20
  JP Z,SET_CLOCK_HL_12
  INC DE

  ; CP $60
  defb $fe	; CP NN
  
; Routine at 29705
L7409:
  LD H,B
  JP C,SET_CLOCK_HL_12
  
IF M10
  LD DE,FONT-276
ELSE
  LD DE,FONT-96
ENDIF

; This entry point is used by the routine at SET_CLOCK_HL.
SET_CLOCK_HL_12:
  PUSH AF
  LD L,A
  LD H,$00
  LD B,H
  LD C,L
  ADD HL,HL
  ADD HL,HL
  ADD HL,BC		; *5
  POP AF
  PUSH AF
  JP C,WIDTH_6
  ADD HL,BC		; *6
WIDTH_6:
  ADD HL,DE
  POP AF
  JP NC,WIDER_FONT
  LD DE,SHAPE
  PUSH DE
  LD B,$05
  CALL LDIR_B
  XOR A
  LD (DE),A		; Character spacing
  POP HL
WIDER_FONT:
  LD D,$01
  CALL LOAD_SHAPE
; This entry point is used by the routine at BOOT.
SET_CLOCK_HL_15:
  XOR A
  LD (GFX_TEMP+3),A
  CALL LCD_INIT_3E

; This entry point is used by the routines at MOVE_CURSOR, UNPLOT and _BEEP.
SET_CLOCK_HL_16:
  LD A,$09
  JR NC,L7409

IF M10
L714A:
  LD A,(BRKCHR+1)		; Extra label between BRKCHR and SHAPE
  LD B,A
  LD DE,10
L7151:
  LD A,(HL)
  DEC B
  JP M,_DRAW_CHAR_1
  ADD HL,DE
  JP L7151
ENDIF

; Move cursor to specified position
;
; Used by the routines at OUTC_SUB and DOTTED_FNAME.
MOVE_CURSOR:
  CALL SETINT_1D
  DEC D
  DEC E
  EX DE,HL
  LD (LCD_ADDR),HL
  JP SET_CLOCK_HL_16

; Plot point on screen  (D,E)
;
; Used by the routine at __PSET.
;
; D = X position (0..239), E = Y position (0..63)
PLOT:
  defb $f6		; OR $AF

; Reset point on screen  (D,E)
;
; Used by the routine at __PSET.
UNPLOT:
  XOR A
  PUSH AF		; Save flags to choose between PLOT and UNPLOT
  CALL SETINT_1D
  PUSH DE
  LD C,$FE
  LD A,D
UNPLOT_0:
  INC C
  INC C
  LD D,A
  SUB $32
  JP NC,UNPLOT_0
  LD B,$00
  LD HL,PLOT_TBL
  LD A,E
  RLA
  RLA
  RLA
  JP NC,L746D
  
;L7469: (
;  LD (HL),H

L746A:
  LD HL,PLOT_TBL2 ; watch out: PLOT_TBL2 <> L746D !

L746D:
  ADD HL,BC
  LD B,A
  CALL SET_LCD_ADDR
  LD A,B
  AND $C0
  OR D
  LD B,A
  LD E,$01
  LD HL,SHAPE
  CALL SET_LCD
  POP DE
  LD D,B
  LD A,E
  AND $07
  ADD A,A
  LD C,A
  LD B,$00
  LD HL,PLOT_TBL
  ADD HL,BC
  POP AF			; Restore flags to choose between PLOT and UNPLOT
  LD A,(HL)
  LD HL,SHAPE
  JP NZ,L7497		; JP to PLOT
  
  CPL				; UNPLOT
  AND (HL)

  DEFB $06	; LD B,N
L7497:
  OR (HL)

  LD (HL),A
  LD B,D
  LD E,$01
  CALL GET_LCD
  JP SET_CLOCK_HL_16
  
; Routine at 29858
;
; Used by the routines at SET_CLOCK_HL and L7409, D=??.
LOAD_SHAPE:
  PUSH HL
  LD E,$06
  LD A,(LCD_ADDR+1)
  CP $08
  JP Z,LOAD_SHAPE_0
  CP $10
  JP Z,LOAD_SHAPE_1
  CP $21
  JP NZ,LOAD_SHAPE_2
LOAD_SHAPE_0:
  DEC E
  DEC E
LOAD_SHAPE_1:
  DEC E
  DEC E
LOAD_SHAPE_2:
  LD C,A
  ADD A,C
  ADD A,C
  LD C,A
  LD B,$00
  LD A,(LCD_ADDR)
  RRA
  RRA
  RRA
  LD HL,GFX_VECT2
  JP C,LOAD_SHAPE_3
  LD HL,GFX_VECT
  
LOAD_SHAPE_3:
  ADD HL,BC
  LD B,A
  CALL SET_LCD_ADDR
  LD (GFX_TEMP),HL
  LD A,B
  OR (HL)
  LD B,A
  POP HL
  DEC D
  CALL SEND_LCD
  INC D
  LD A,$06
  SUB E
  RET Z
  LD E,A
  PUSH HL
  LD HL,(GFX_TEMP)
  INC HL
  CALL SET_LCD_ADDR
  POP HL
  LD A,B
  AND $C0
  LD B,A
  DEC D
  
;L74F4:
  ;JP C,$AFF6
  defb $da		; JP C,NN

SET_LCD:
	DEFB $F6	;OR $AF (masks XOR A)

; This entry point is used by the routine at UNPLOT.

; Routine at 29942
;
; Used by the routine at L7497.
; Rebuild graphics character code to finalize PLOT/UNPLOT
GET_LCD:
  XOR A
  
; This entry point is used by the routine at L7497.
SEND_LCD:
  PUSH DE
  PUSH AF
  LD A,B
  CALL WAIT_LCD
SEND_LCD_0:
  OUT ($FE),A
  JP Z,UNPLOT_8
  CALL WAIT_LCD
  IN A,($FF)
UNPLOT_8:
  POP AF
  JP NZ,DO_GET_LCD

DO_SEND_LCD:
  IN A,($FE)	; read display status
  RLA				; busy ?
  JP C,DO_SEND_LCD	; if so, keep looping
  LD A,(HL)
  OUT ($FF),A
  INC HL
  DEC E
  JP NZ,DO_SEND_LCD
  POP DE
  RET

DO_GET_LCD:
  IN A,($FE)	; read display status
  RLA				; busy ?
  JP C,DO_GET_LCD	; if so, keep looping
  IN A,($FF)
  LD (HL),A
  INC HL
  DEC E
  JP NZ,DO_GET_LCD
  POP DE
  RET
  
; This entry point is used by the routines at IOINIT and SET_CLOCK_HL.
LCD_INIT_3E:
  CALL INIT_LCD_ADDR
  LD A,$3E
  OUT ($FE),A
  RET
  
; This entry point is used by the routine at IOINIT.
INIT_LCD_ADDR:
  LD C,$03
  CALL DELAY_C
  LD HL,L7641		; OUT ($B9),$FF, OR $03

SET_LCD_ADDR:
  LD A,(HL)
  OUT ($B9),A
  INC HL
  IN A,($BA)
  AND $FC
  OR (HL)
  OUT ($BA),A
  INC HL
  RET
  
WAIT_LCD:
  PUSH AF
WAIT_LCD_0:
  IN A,($FE)	; read display status
  RLA				; busy ?
  JP C,WAIT_LCD_0	; if so, keep looping
  POP AF
  RET



; Message at 30033
GFX_VECT:
  DEFB $01, $00, $00
  DEFB $01, $00, $06
  DEFB $01, $00, $0C
  DEFB $01, $00, $12
  DEFB $01, $00, $18
  DEFB $01, $00, $1E
  DEFB $01, $00, $24
  DEFB $01, $00, $2A
  DEFB $01, $00, $30
  DEFB $02, $00, $04
  DEFB $02, $00, $0A
  DEFB $02, $00, $10
  DEFB $02, $00, $16
  DEFB $02, $00, $1C
  DEFB $02, $00, $22
  DEFB $02, $00, $28
  DEFB $02, $00, $2E
  DEFB $04, $00, $02
  DEFB $04, $00, $08
  DEFB $04, $00, $0E
  DEFB $04, $00, $14
  DEFB $04, $00, $1A
  DEFB $04, $00, $20
  DEFB $04, $00, $26
  DEFB $04, $00, $2C
  DEFB $08, $00, $00
  DEFB $08, $00, $06
  DEFB $08, $00, $0C
  DEFB $08, $00, $12
  DEFB $08, $00, $18
  DEFB $08, $00, $1E
  DEFB $08, $00, $24
  DEFB $08, $00, $2A
  DEFB $08, $00, $30
  DEFB $10, $00, $04
  DEFB $10, $00, $0A
  DEFB $10, $00, $10
  DEFB $10, $00, $16
  DEFB $10, $00, $1C
  DEFB $10, $00, $22
  
GFX_VECT2:
  DEFB $20, $00, $00
  DEFB $20, $00, $06
  DEFB $20, $00, $0C
  DEFB $20, $00, $12
  DEFB $20, $00, $18
  DEFB $20, $00, $1E
  DEFB $20, $00, $24
  DEFB $20, $00, $2A
  DEFB $20, $00, $30
  DEFB $40, $00, $04
  DEFB $40, $00, $0A
  DEFB $40, $00, $10
  DEFB $40, $00, $16
  DEFB $40, $00, $1C
  DEFB $40, $00, $22
  DEFB $40, $00, $28
  DEFB $40, $00, $2E
  DEFB $80, $00, $02
  DEFB $80, $00, $08
  DEFB $80, $00, $0E
  DEFB $80, $00, $14
  DEFB $80, $00, $1A
  DEFB $80, $00, $20
  DEFB $80, $00, $26
  DEFB $80, $00, $2C
  DEFB $00, $01, $00
  DEFB $00, $01, $06
  DEFB $00, $01, $0C
  DEFB $00, $01, $12
  DEFB $00, $01, $18
  DEFB $00, $01, $1E
  DEFB $00, $01, $24
  DEFB $00, $01, $2A
  DEFB $00, $01, $30
  DEFB $00, $02, $04
  DEFB $00, $02, $0A
  DEFB $00, $02, $10
  DEFB $00, $02, $16
  DEFB $00, $02, $1C
  DEFB $00, $02, $22
  
L7641:
  DEFB $FF, $03
  

; Table to build/edit the graphics symbols used by PLOT/UNPLOT
PLOT_TBL:
  DEFB $01, $00
  DEFB $02, $00
  DEFB $04, $00
  DEFB $08, $00
  DEFB $10, $00

PLOT_TBL2:
  DEFB $20, $00
  DEFB $40, $00
  DEFB $80, $00
  DEFB $00, $01
  DEFB $00, $02


; Routine at 30295
;
; Used by the routines at MUSIC, SET_CLOCK_HL, UNPLOT and _BEEP.
DELAY_C:
  DEC C
  JP NZ,DELAY_C
  RET

; Set interrupt to 1DH
;
; Used by the routines at PRINTR, KYREAD, SET_CLOCK_HL, MOVE_CURSOR, PLOT, UNPLOT and
; _BEEP.
SETINT_1D:
  DI
  LD A,$1D
  JR NC,SETINT_1D
  RET

; Beep routine (07H)
_BEEP:
  CALL SETINT_1D
  LD B,$00
_BEEP_0:
  CALL _CLICK
  LD C,$50
  CALL DELAY_C
  DEC B
  JP NZ,_BEEP_0
  JP SET_CLOCK_HL_16

; Click sound port
;
; Used by the routines at CLICK, CASS_PROBE and _BEEP.
_CLICK:
  IN A,($BA)
  XOR $20
  OUT ($BA),A
  RET
  
_CLICK_0:
  LD A,(IOFLAGS+1)
  INC A
  RET
  
; This entry point is used by the routines at _RST75 and IOINIT.
_CLICK_1:
  LD HL,IOFLAGS+1
  IN A,($82)
  AND $07
  JP Z,_CLICK_2
  LD (HL),$00
  RET
  
_CLICK_2:
  OR (HL)
  RET NZ
  LD (HL),$FF
_CLICK_3:
  LD A,$C1
  OUT ($83),A
  IN A,($80)
  LD A,$04
  OUT ($81),A
  OUT ($80),A
  RET
  
; This entry point is used by the routine at IOINIT.
_CLICK_4:
IF M100
  CALL _CLICK_0
ENDIF
IF KC85 | M10
  CALL _CLICK_1
ENDIF
  SCF
  RET NZ
  LD A,$03
  LD (IOFLAGS),A
  XOR A
  CALL _CLICK_8
  CALL _CLICK_12
  RLCA
  RLCA
  AND $03
  RET
  
; This entry point is used by the routine at IOINIT.
_CLICK_5:
  LD A,$03
  LD (IOFLAGS),A
  LD HL,L770B
  LD B,$05
_CLICK_6:
  LD A,(HL)
  CALL _CLICK_8
  INC HL
  DEC B
  JP NZ,_CLICK_6
  CALL _CLICK_12
  OR A
  SCF
  RET NZ
  LD HL,$E000
_CLICK_7:
  CALL _CLICK_12
  LD (HL),A
  INC HL
  DEC B
  JP NZ,_CLICK_7
  JP $E000
  
_CLICK_8:
  PUSH AF
  
_CLICK_9:
  CALL BREAK
  JP C,_CLICK_10
  IN A,($82)
  RLCA
  JP NC,_CLICK_9
  LD A,(IOFLAGS)
  OUT ($81),A
  POP AF
  OUT ($80),A
  RET
  
_CLICK_10:
  POP AF
_CLICK_11:
  POP AF
  CALL _CLICK_3
  SCF
  RET

_CLICK_12:
  CALL BREAK
  JP C,_CLICK_11
  IN A,($82)
  AND $20
  JP Z,_CLICK_12
  IN A,($80)
  RET
  
; Message at 30475
L770B:
  DEFB $02
  DEFB $01
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $00

; FONT: 5 bytes for 0..127 (ASCII), 6 bytes for 128..255 (GRAPHICS), total 1248 bytes
FONT:
IF M10

; 480 bytes for ASCII FONT
  BINARY  "M10FONT_L.BIN"
  
; 588 bytes (98*6) for both ASCII and GFX symbols
  BINARY  "M10FONT_H.BIN"
  
ELSE
; KC85 and M100 GFX fonts are identical.

; 480 bytes for ASCII FONT
  BINARY  "FONT_L.BIN"

; 768 bytes for GFX SYMBOLS
  BINARY  "FONT_H.BIN"

ENDIF

; End of LCD character generator shape table.

; Start of keyboard conversion matrix
;L7BF1:
IF M10




; 10 elements
ASCII_SYM:
  DEFM "#@[\\]`{|}~"

  DEFB $bf 
  DEFB $ee, $a1

KMAP0:
  DEFB $a2, $a3, $60, $d1, $d2, $d3, $de
  DEFB $23
  DEFB $ee, $cf, $9e, $e1, $ec, $df, $ea, $e2, $e5
  DEFB $23
  DEFB $df, $cf, $9e, $ee, $60, $e1, $ec, $e2, $9f

  DEFM "qw[12345y67890-^]@;:/.,ma\\z"
  DEFM "QW{!\"#$%Y&'()_=~}`+*?><MA|Z"
  
  DEFM "qw+12345z67890~'#}|{-.,ma<y"
  DEFM "QW*!\"@$%Z&/()=?`^]\\[_:;MA>Y"
  
  DEFM "qz$#]\"'(y_}^\\{)-*~m`|:;,a<w"
  DEFM "QZ&12345Y67890[+@=M%!/.?A>W"

  DEFM "az$#{\"'(y-}_\\@)=`^m|!:;,q<w"
KMAP1:
  DEFM "AZ*12345Y67890[+&~M%]/"
L7952:
  DEFM ".?Q>W"

  DEFM "xcvbn"
L795C:
  DEFM "sdfghjkler"
  DEFM "tuiop"

KMAP2:
  DEFB " "
  DEFB $1d, $1c, $1e, $1f, $08

L7971:
  DEFB $09, $0d, $8b
  
  DEFB $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $1b

  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $11
  DEFB $12
  DEFB $17
  DEFB $1A
  DEFM "XCVBNSDFGHJKLERTUIOP "
  DEFB $01
  DEFB $06
  DEFB $14
  DEFB $02
  DEFB $7F
  DEFB $09
  DEFB $0D
  
  DEFB $8B
  DEFB $80
  DEFB $81          ; ? TK_FOR ?
  DEFB $82
  DEFB $83
  DEFB $84
  DEFB $85
  DEFB $86
  DEFB $87
  DEFB $88
  DEFB $8A

ELSE
KBDMAP_LCASE:
  DEFM "zxcvbnmlasdfghjkqwertyuiop[;',./1234567890-="
ENDIF

IF M10
; 12 pairs
L79AD:
  DEFB $15
  DEFM "."
  DEFB $16
  DEFM ","
  DEFB $17
  DEFB '0'
  DEFB $25
  DEFB '1'
  DEFB $26
  DEFB '2'
  DEFB $27
  DEFB '3'
  DEFB $2B
  DEFB '4'
  DEFB $2C
  DEFB '5'
  DEFB $2D
  DEFB '6'
  DEFB $0A
  DEFB '7'
  DEFB $0B
  DEFB '8'
  DEFB $0C
  DEFB '9'
  
  
KMAP3:
  DEFB $df
  DEFB $e0, $d1, $d2, $d3, $d4, $d5, $d6
  DEFB $e4, $d7, $d8, $d9, $da, $db, $dc, $dd, $de 
  DEFB $e9, $f3, $f4, $d0, $fe, $fd, $fc, $ea 
  DEFB $f5, $f6, $f7, $f8, $f9, $fa, $fb
  DEFB $eb, $ec, $ed, $ee, $ef, $f0, $f1, $f2
  DEFB $e1, $e2, $e3, $e5, $e6, $e7, $e8
  
  DEFB $af
  DEFB $b0, $a1, $a2, $a3, $a4, $a5, $a6
  DEFB $b4, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae
  DEFB $b9, $c3, $c4, $cf, $ce, $cd, $cc, $ba
  DEFB $c5, $c6, $c7, $c8, $c9, $ca, $cb
  DEFB $bb, $bc, $bd, $be, $bf, $c0, $c1, $c2
  DEFB $b1, $b2, $b3, $b5, $b6, $b7, $b8
  
ELSE

; Message at 31773
;L7C1D:
KBDMAP_UCASE:
  DEFM "ZXCVBNMLASDFGHJKQWERTYUIOP]:\"<>?!@#$%^&*()_+"

L7C49:
  DEFB $00
  DEFB $83
  DEFB $84
  DEFB $00
  DEFB $95
  DEFB $96
  DEFB $81
  DEFB $9A
  DEFB $85
  DEFB $8B
  DEFB $00
  DEFB $82
  DEFB $00
  DEFB $86
  DEFB $00
  DEFB $9B
  DEFB $93
  DEFB $94
  DEFB $8F
  DEFB $89
  DEFB $87
  DEFB $90
  DEFB $91
  DEFB $8E
  DEFB $98
  DEFB $80
  DEFB $60
  DEFB $92
  DEFB $8C
  DEFB $99
  DEFB $97
  DEFB $8A
  DEFB $88
  DEFB $9C
  DEFB $9D
  DEFB $9E
  DEFB $9F
  DEFB $B4
  DEFB $B0
  DEFB $A3
  DEFB $7B		; "{"
  DEFB $7D		; "}"
  DEFB $5C		; "\"
  DEFB $8D
  DEFB $E0
  DEFB $EF
  DEFB $FF
  DEFB $00
  DEFB $00
  DEFB $00

  DEFB $F6
  DEFB $F9
  DEFB $EB
  DEFB $EC
  DEFB $ED
  DEFB $EE
  DEFB $FD
  DEFB $FB
  DEFB $F4
  DEFB $FA

  DEFB $E7
  DEFB $E8
  DEFB $E9
  DEFB $EA  
  DEFB $FC
  DEFB $FE
  DEFB $F0
  DEFB $F3
  DEFB $F2
  DEFB $F1
  DEFM $7E		;"~"
  DEFB $F5
  DEFB $00
  DEFB $F8
  DEFB $F7
  DEFB $00

  DEFB $E1
  DEFB $E2
  DEFB $E3
  DEFB $E4
  DEFB $E5
  DEFB $E6
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFM $7C		;"|"
  DEFB $00
  
KMAP3:
  DEFB $CE
  DEFB $A1
  DEFB $A2
  DEFB $BD
  DEFB $00
  DEFB $CD
  DEFB $00
  DEFB $CA
  DEFB $B6
  DEFB $A9
  DEFB $BB
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $CB
  DEFB $C9
  DEFB $C8
  DEFB $00
  DEFB $C6
  DEFB $00
  DEFB $00
  DEFB $CC
  DEFB $B8
  DEFB $C7
  DEFB $B7
  DEFB $AC
  DEFB $B5
  DEFB $AD
  DEFB $A0
  DEFB $BC
  DEFB $CF
  DEFB $AE
  DEFB $C0
  DEFB $00
  DEFB $C1
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $C4
  DEFB $C2
  DEFB $C3
  DEFB $AF
  DEFB $C5
  DEFB $BE
  DEFB $00
  DEFB $DF
  DEFB $AB
  DEFB $DE
  DEFB $00
  DEFB $00
  DEFB $A5
  DEFB $DA
  DEFB $B1
  DEFB $B9
  DEFB $D7
  DEFB $BF
  DEFB $00
  DEFB $00


; Message at 31963
KMAP2:
  DEFB $DB
  DEFB $D9
  DEFB $D8
  DEFB $00
  DEFB $D6
  DEFB $AA
  DEFB $BA
  DEFB $DC
  DEFB $B3
  DEFB $D5
  DEFB $B2
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $A4
  DEFB $DD
  DEFB $00
  DEFB $00
  
  DEFB $D0
  DEFB $00

; Message at 31983
KMAP1:
  DEFB $D1
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $D4
  DEFB $D2
  DEFB $D3
  DEFB $A6
  DEFB $A7
  DEFB $A8

; Message at 31993
L7CF9:
  DEFM "m0j1k2l3u4i5o6"
  DEFB $01
  DEFB $06
  DEFB $14
  DEFB $02
  DEFM " "
  DEFB $7F
  DEFB $09
  DEFB $1B
  DEFB $8B
  DEFB $88
  DEFB $8A
  
  DEFB $0D
  DEFB $80
  DEFB $81
  DEFB $82
  DEFB $83
  DEFB $84
  DEFB $85
  DEFB $86
  DEFB $87
  DEFB $1D
  DEFB $1C
  DEFB $1E
  DEFB $1F
  DEFM " "
  DEFB $08
  DEFB $09
  DEFB $1B
  DEFB $8B
  DEFB $88
  DEFB $89
  
  DEFB $0D
  DEFB $80
  DEFB $81
  DEFB $82
  DEFB $83
  DEFB $84
  DEFB $85
  DEFB $86
  DEFB $87
L7D2F:
  DEFM "QRWZ"
;  DEFB $51
;  DEFB $52
;  DEFB $57
;  DEFB $5A

ENDIF



; Boot routine
;
; Used by the routine at $0000.
BOOT:
  DI
  LD SP,ALT_LCD
  
IF KC85
  CALL DELAY_C
BOOT_0:
  IN A,($D8)
  AND A
  JP P,BOOT_0
ENDIF

IF M100
  LD HL,10000	; delay
ENDIF
IF M10
  LD HL,30000	; delay
ENDIF
IF M100 | M10
BOOT_DELAY:
  DEC HL
  LD A,H
  OR L
  JP NZ,BOOT_DELAY
ENDIF

  LD A,$43
  OUT ($B8),A
  LD A,$EC
  OUT ($BA),A
  LD A,$FF
  OUT ($B9),A
  IN A,($E8)
IF M10
  AND $88
ELSE
  AND $82
ENDIF
  LD A,$ED
  OUT ($BA),A
  JP Z,BOOT_4
  
  LD HL,(MAXRAM)
  LD DE,$8A4D	; Value for MAXRAM
  RST CPDEHL
  JP NZ,BOOT_4
  LD A,(RAM+1)
  LD D,A
  CALL TEST_FREEMEM
  CP D
  JP NZ,BOOT_4
  CALL EXTROM_TST
  LD A,$00
  JP NZ,BOOT_1
  DEC A
BOOT_1:
  LD HL,OPTROM
  CP (HL)
  JP NZ,BOOT_4
  LD HL,(ATIDSV)	; Address to jump to resume
  EX DE,HL
  LD HL,$0000
  LD (ATIDSV),HL	; Address to jump to resume
  LD HL,$9C0B	; POWER ON data marker
  RST CPDEHL
  JP NZ,BOOT_2
  LD HL,(STAKSV)
  LD SP,HL
  CALL BOOT_VECT
  CALL L7DD0
  LD HL,(SAVSP)
  PUSH HL

IF KC85 | M10
  LD A,(MENU_FLG)
  AND A
  JP NZ,BOOT_3
ENDIF

  CALL ESC_J_13
  POP HL
  LD A,H
  AND A
  JP Z,POPALL
  LD SP,HL
  JP SET_CLOCK_HL_15

BOOT_2:
  LD A,(EDITMODE)
  AND A
  JP Z,BOOT_3
  CALL L7DD0
  CALL STKINI
  CALL ESC_J_13
  JP WAIT_SPC_5

BOOT_3:
  LD HL,IPL_FNAME
  LD (FNKPNT),HL
  LD HL,(STKTOP)
  LD SP,HL
  CALL BOOT_VECT
  CALL _CLREG_1
  LD HL,__MENU
  PUSH HL

	DEFB $F6	; OR $AF

; Routine at 32208
;
; Used by the routine at BOOT.
L7DD0:
  XOR A
  CALL IOINIT
  XOR A
  LD (POWR_FLAG),A
  LD A,(RS232_FLG)
  AND A
  RET Z
  LD HL,STAT-1
  RST CHRGTB		; Gets next character (or token) from BASIC text.
  CALL NC,INCHL
  JP SETSER

BOOT_4:
  LD SP,STACK_INIT
  CALL TEST_FREEMEM
  LD B,PIVOT_CODE_END-PIVOT_CODE
  LD DE,MAXRAM
  LD HL,PIVOT_CODE
  CALL LDIR_B
  CALL INIT_HOOKS
  LD A,$0C
  LD (TIMCN2),A
  LD A,$64
  LD (TIMINT),A
  LD HL,FNKTAB
  CALL STFNK
  CALL SAVE_BA_LBL
  LD B,ROM_PROGS_END-ROM_PROGS
  LD DE,ROM_PROGS
  LD HL,DIRECTORY
  CALL REV_LDIR_B

  ; - Custom target init code -

IF M100
  LD B,$D1
  XOR A
BOOT_5:
  LD (HL),A
  INC HL
  DEC B
  JP NZ,BOOT_5
ENDIF

IF KC85 | M10
IF M10
  LD B,$D1
ELSE
  LD B,$E7
ENDIF
  CALL ZERO_MEM
ENDIF

  LD (HL),$FF
  CALL EXTROM_TST
  JP NZ,BOOT_6
  DEC A
  LD (OPTROM),A
  LD HL,USRDIR
  LD (HL),$F0
  INC HL
  INC HL
  INC HL
  LD DE,OPTROM_SIG+2
  LD B,$06
  CALL REV_LDIR_B
  LD (HL),' '
  INC HL
IF M100
  LD (HL),$00
ENDIF
IF KC85 | M10
  LD (HL),B
ENDIF
BOOT_6:
  XOR A
  LD (ENDBUF),A
  LD (NLONLY),A
  CALL ERASE_IPL
  LD (TMOFLG),A
  LD A,':'
  LD (BUFFER),A         ; a colon for restarting input
  LD HL,PRMSTK			; ptr to previous block definition on stack
  LD (PRMPRV),HL
  
  LD (STKTOP),HL
  LD (MEMSIZ),HL
  LD A,$01
  LD (VARTAB+1),A
  CALL __MAX_0
  CALL _CLREG_1
  LD HL,(RAM)		; Lowest RAM memory address used by system ($8000 if 32K RAM)
  XOR A
  LD (HL),A
  INC HL
  LD (BASTXT),HL
  LD (SUZUKI),HL
  LD (HL),A
  INC HL
  LD (HL),A
  INC HL
  LD (DO_FILES),HL
  LD (HAYASHI),HL		; Paste buffer file
  LD (HL),$1A		; EOF
  INC HL
  LD (CO_FILES),HL
  LD (VARTAB),HL
  LD HL,SUZUKI-1
  LD (DIRPNT),HL
  CALL CLRPTR
  CALL INITIO
  LD HL,$0000
  LD (YEAR),HL
  LD HL,RESET_CLK_DATA
  CALL SET_CLOCK_HL
  JP __MENU

; This entry point is used by the routine at BASIC.
PRINT_COPYRIGHT:
  LD HL,PROMPT_MSG
  CALL PRS

; Display the number of free memory bytes on the screen.
;
; Used by the routine at __MENU.
FREEMEM:
  LD HL,(VARTAB)
  EX DE,HL
  LD HL,(STKTOP)
  LD A,L
  SUB E
  LD L,A
  LD A,H
  SBC A,D
  LD H,A
  LD BC,-14
  ADD HL,BC
  CALL NUMPRT
  LD HL,FREE_MSG
  JP PRS
  
; This entry point is used by the routine at BOOT.
INIT_HOOKS:
  LD HL,RST38_VECT

IF KC85 | M10
  LD BC,$2402	; B=36, C=2
ENDIF

IF M100
  LD BC,$1D02	; B=29, C=2
ENDIF

  LD DE,NULSUB	; 29 words initialized with NULSUB
FREEMEM_1:
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  DEC B
  JP NZ,FREEMEM_1
IF KC85 | M10
  LD B,18		; 18*2 = 36 words initialized with 'FC_ERR'
ENDIF
IF M100
  LD B,19		; 19*2 = 38 words initialized with 'FC_ERR'
ENDIF
  LD DE,FC_ERR	; 
  DEC C
  JP NZ,FREEMEM_1
  RET

; This entry point is used by the routine at BOOT.
; Put in (RAM) the lowest memory address used by system ($8000 if 32K RAM)
TEST_FREEMEM:
  LD HL,$C000
FREEMEM_LOOP:
  LD A,(HL)
  CPL
  LD (HL),A
  CP (HL)
  CPL
  LD (HL),A
  LD A,H
  JP NZ,FREEMEM_DONE
  INC L
  JP NZ,FREEMEM_LOOP
  SUB $20
  LD H,A
  JP M,FREEMEM_LOOP
FREEMEM_DONE:
  LD L,$00
  ADD A,$20
  LD H,A
  LD (RAM),HL
  RET

; Message at 32513
RESET_CLK_DATA:
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $00
  DEFB $01
  DEFB $00
  DEFB $00
  DEFB $01


; Routine at 32523
__MAX:
  RST SYNCHR
  DEFB TK_FILES       ; Token code for "FILES" keyword
  RST SYNCHR
  DEFB TK_EQUAL	      ; Token for '='
  CALL GETINT         ; Get integer 0-255
  JP NZ,SN_ERR
  CP $10
  JP NC,FC_ERR
  LD (TEMP),HL
  PUSH AF
  CALL CLSALL
  POP AF
  CALL __MAX_0
  CALL _CLREG
  JP NEWSTT
  
; This entry point is used by the routines at __CLEAR and BOOT.
__MAX_0:
  PUSH AF
  LD HL,(HIMEM)
  LD DE,-267 		; (same offset on MSX)
__MAX_1:
  ADD HL,DE
  DEC A
  JP P,__MAX_1
  EX DE,HL
  LD HL,(STKTOP)
  LD B,H
  LD C,L
  LD HL,(MEMSIZ)
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A
  POP AF
  PUSH HL
  PUSH AF
  LD BC,$008C
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,(VARTAB)
  ADD HL,BC
  RST CPDEHL
  JP NC,OM_ERR
  POP AF
  LD (MAXFIL),A
  LD L,E
  LD H,D
  LD (FILTAB),HL
  DEC HL
  DEC HL
  LD (MEMSIZ),HL
  POP BC
  LD A,L
  SUB C
  LD L,A
  LD A,H
  SBC A,B
  LD H,A
  LD (STKTOP),HL
  DEC HL
  DEC HL
  POP BC
  LD SP,HL
  PUSH BC
  LD A,(MAXFIL)
  LD L,A
  INC L
  LD H,$00
  ADD HL,HL
  ADD HL,DE
  EX DE,HL
  PUSH DE
  LD BC,$0109		; 265
__MAX_2:
  LD (HL),E
  INC HL
  LD (HL),D
  INC HL
  EX DE,HL
  LD (HL),$00
  ADD HL,BC
  EX DE,HL
  DEC A
  JP P,__MAX_2
  POP HL
  LD BC,$0009
  ADD HL,BC
  LD (FILTAB+4),HL
  RET

; Message at 32664
FREE_MSG:
  DEFM " Bytes free"
  DEFB $00

; Message at 32676
PROMPT_MSG:
IF M100
  DEFM "TRS-80 Model 100 Software"
  DEFB $0D
  DEFB $0A
  DEFM "Copr. 1983 Microsoft"
ENDIF

IF KC85
  DEFM "Software Copr. 1983 Microsoft"
ENDIF

IF M10
  DEFM "OLIVETTI M10 BASIC 1.0"
  DEFB $0D, $0A
  DEFM "(C) 1983 Microsoft"
ENDIF

  DEFB $0D
  DEFB $0A
  DEFB $00

IF KC85
  DEFS 18
ENDIF

; RST 38H RAM vector driver routine (see 38H)
;
; Used by the routine at RST38H.
_RST38H:
  EX (SP),HL
  PUSH AF
  LD A,(HL)
  LD (RST38_OFFS),A
_RST38H_0:
  POP AF
  INC HL
  EX (SP),HL
  PUSH HL
  PUSH BC
  PUSH AF
  LD HL,RST38_VECT
  LD A,(RST38_OFFS)
  LD C,A
  LD B,$00
  ADD HL,BC
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  POP AF
_RST38H_1:
  POP BC
  EX (SP),HL
; Routine at 32755
NULSUB:
  RET

IF M100
; This entry point is used by the routine at INTEXP.
FACCU2ARG:
  CALL __CDBL
  JP FAC1_ARG
ENDIF

IF KC85 | M10
; This entry point is used by the routine at TXT_CTL_Q.
TXT_CTL_N_SUB:
  LD HL,(CSRX)
  LD (SAVE_CSRX),HL
  LD HL,TXT_EXIT_ASK
  LD (ERRTRP),HL
  JP TXT_CTL_N_3

; This entry point is used by the routine at __MENU.
_RUN_FST:
IF M10
  PUSH HL
ENDIF
  LD HL,LLIST_STMT
_RUN_FST_0:
  LD (SHFT_PRINT),HL
IF M10
  POP HL
  JP NEWSTT
ELSE
  JP RUN_FST
ENDIF
ENDIF

IF KC85
; This entry point is used by the routine at USING.
_TSTSTR:
  CALL TSTSTR
  PUSH HL
  LD HL,(FACLOW)
  LD DE,MAXRAM
  RST CPDEHL
  EX DE,HL
  CALL C,PUTTMP
  POP HL
  RET
ENDIF


L0END:
	;defs 6
  defs $8000-L0END

IF M10
  RST $38
  DEFB $da
  
  defs 14
ENDIF
