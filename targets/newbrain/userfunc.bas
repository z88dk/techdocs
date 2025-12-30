59000 REM user defined functions for the Newbrain
59001 REM copyright (c) Alun Morris 4:5:1984
59005 REM hex nibble to decimal
59010 DEF FNni(a$)=(INSTR(" 123456789ABCDEF0123456789abcdef",a$)-1)AND15
59015 REM hex byte to decimal
59020 DEF FNdb(a$)=16*FNni(LEFT$(RIGHT$(a$,2),-(LEN(a$)>1)))+FNni(RIGHT$(a$,1))
59025 REM hex word to decimal
59030 DEF FNdw(a$)=4096*FNni(LEFT$(RIGHT$(a$,4),-(LEN(a$)>3)))+256*FNni(LEFT$(RIGHT$(a$,3),-(LEN(a$)>2)))+16*FNni(LEFT$(RIGHT$(a$,2),-(LEN(a$)>1)))+FNni(RIGHT$(a$,1))
59035 REM valid hex nibble
59040 DEF FNvn(a$)=(INSTR(" 123456789ABCDEFabcdef0",a$)>0)
59045 REM valid hex byte
59050 DEF FNvb(a$)=FNvn(LEFT$(RIGHT$(a$,2),-(LEN(a$)>1))) AND FNvn(RIGHT$(a$,1))
59055 REM valid hex word
59060 DEF FNvw(a$)=FNvb(LEFT$(RIGHT$(a$,4),2)) AND FNvb(RIGHT$(a$,2))
59065 REM one byte decimal to hex 
59070 DEF FNhb$(i)=MID$("0123456789ABCDEF",INT(i/16)+1,1)+MID$("0123456789ABCDEF",(iAND15)+1,1)
59075 REM one word decimal to hex
59080 DEF FNhx$(i)=FNhb$(INT(i/256))+FNhb$((i-32768)AND255)
59085 REM return address at parameter's location
59090 DEF FNad(i)=256*PEEK(i+1)+PEEK(i)
59095 REM decimal to binary (one nibble)
59100 DEF FNbn$(i)=MID$("0000000100100011010001010110011110001001101010111100110111101111",i*4+1,4)
59105 REM decimal to binary (one byte)
59110 DEF FNbi$(i)=FNbn$(INT(i/16))+FNbn$(iAND15)
59115 REM 8 bit binary to decimal 
59120 DEF FNbd(a$)=FNb1(RIGHT$("00000000"+a$,8))
59125 REM FNs used by FNbd(a$)
59130 DEF FNb1(a$)=FNb2(RIGHT$(a$,2))+4*(FNb2(MID$(a$,5,2))+4*(FNb2(MID$(a$,3,2))+4*(FNb2(LEFT$(a$,2)))))
59140 DEF FNb2(a$)=(INSTR("00 01 10 11",a$)-1)/3
59145 REM return high byte of 2 byte number
59150 DEF FNhi(i)=INT(i/256)
59155 REM return low byte of 2 byte number
59160 DEF FNlo(i)=(i-32768)AND255
59165 REM return i spaces, up to 80
59170 DEF FNsp$(i)=LEFT$("                             { type 80 spaces }                               ",i)
59175 REM return i backspaces, up to 40
59180 DEF FNbs$(i)=LEFT$("{ type in 40 x (ESCAPE then cursor left }",i)
59185 REM return screen location of screen row x,y. a$=chr$(x)+chr$(y)
59190 DEF FNsl(a$)=FNad(92)+PEEK(FNad(92))+4+ASC(a$)+(ASC(MID$(a$,2))-1)*PEEK(FNad(92)+6)
59195 REM return RESERVE number to reserve to location i.  i can be >TOP
59196 REM use RESERVE FNre(i)
59200 DEF FNre(i)=TOP-i-2^16*(TOP<i)
59205 REM return size of: source code (excluding line numbers) (i=0)
59206 REM                 object code (i=1)
59210 DEF FNsz(i)=(1-2*i)*FNad(FNad(22)+14)+i*FNad(FNad(22)+16)+(i-1)*(FNad(22)+61)
59215 REM return position of source code of ith line from top of program
59220 DEF FNsc(i)=FNad(TOP-i*6-4)
59225 REM check string for yes or no response.  True if yes or no.
59230 DEF FNyn(a$)=(INSTR(" YyNn",LEFT$(a$,1))>1)
