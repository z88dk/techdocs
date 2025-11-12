;
;	BDOS ENTRY DECLARATIONS FOR THE CP/M TOOLS WRITTEN IN PLM
;
;	This is a replacement declaration file to be used
; in place of the OS5TRINT available in the CP/M 2.2 sources
;
; It must be assembled with the ISIS II ASM80
; and linked to the programs built with PLM80

offset	equ	6000h

boot	equ	offset
mon1	equ	0005h+offset
mon2	equ	0005h+offset
mon2a	equ	0005h+offset
mon3 	equ	0005h+offset

	public	boot,mon1,mon2,mon2a,mon3


;	EXTERNAL BASE PAGE DATA LOCATIONS

iobyte	equ	0003h+offset
bdisk	equ	0004h+offset
maxb	equ	0006h+offset
memsiz	equ	maxb
cmdrv	equ	0050h+offset
pass0	equ	0051h+offset
len0	equ	0053h+offset
pass1	equ	0054h+offset
len1	equ	0056h+offset
fcb	equ	005ch+offset
fcba	equ	fcb
sfcb	equ	fcb
ifcb	equ	fcb
ifcba	equ	fcb
fcb16	equ	006ch+offset
dolla	equ	006dh+offset
parma	equ	006eh+offset
cr	equ	007ch+offset
rr	equ	007dh+offset
rreca	equ	rr
ro	equ	007fh+offset
rreco	equ	ro
tbuff	equ	0080h+offset
buff	equ	tbuff
buffa	equ	tbuff
cpu	equ	0	; 0 = 8080, 1 = 8086/88, 2 = 68000

	public	iobyte,bdisk,maxb,memsiz
	public	cmdrv,pass0,len0,pass1,len1
	public	fcb,fcba,sfcb,ifcb,ifcba,fcb16
	public	cr,rr,rreca,ro,rreco,dolla,parma
	public	buff,tbuff,buffa, cpu


END
