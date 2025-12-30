{---------------------  GRAPHICS ROUTINES --------------------------}
{  This implements ALL of the BASIC plot commands, except the flag  }
{  command (which doesn't work!). Devices 11 and 33 supported.      }
{-------------------------------------------------------------------}


{ graphics need NewBrain floating-point parameters }

PROCEDURE float(n:INTEGER);   { store converted number in fpstore}
VAR neg:BOOLEAN;
BEGIN
    neg := (n < 0);
    n := ABS(n);
    register[D] := hichar(n);
    register[E] := lochar(n);
    zcall(zflt);
    register[H] := hichar(ADDR(fpstore));
    register[L] := lochar(ADDR(fpstore));
    zcall(zstf);
    IF neg THEN fpstore[1] := SUCC(fpstore[1]);
END;

FUNCTION unfloat:INTEGER;  { convert value held in fpstore to 16bit signed int}
VAR n:INTEGER; neg: BOOLEAN;
BEGIN
    neg := FALSE;
    IF ODD(ORD(fpstore[1])) THEN BEGIN
       fpstore[1] := PRED(fpstore[1]);
       neg := TRUE
    END;
    register[H] := hichar(ADDR(fpstore));
    register[L] := lochar(ADDR(fpstore));
    zcall(zldf); zcall(zround);
    n := PEEK(ADDR(register[E]),INTEGER);
    IF neg THEN unfloat := -n  ELSE unfloat := n;
END;

PROCEDURE putfp(stream,n:INTEGER); 
VAR I:INTEGER;
BEGIN
    float(n);
    register[E] := CHR(stream);
    FOR I := 1 TO 6 DO putc(stream, fpstore[I]);
END;

{ The basic primitive routine }

PROCEDURE gcall(code,count:INTEGER);
VAR I:INTEGER;
BEGIN
   putc(grstrm, CHR(16));
   putc(grstrm, CHR(code));
   IF (count > 0) THEN BEGIN
      FOR I := 1 TO count DO
	 putfp(grstrm,gparam[I]);
   END;
END;

{ The following are exact counterparts to NewBrain BASIC plot statements}

PROCEDURE move(x,y:INTEGER);  { NB only integers ! }
BEGIN
   gparam[1] := x; gparam[2] := y;
   gcall(0,2);
END;

PROCEDURE turn (angle:INTEGER);
BEGIN
   gparam[1] := angle;
   gcall(1,1);
END;

PROCEDURE arc(length,angle:INTEGER);
BEGIN
   gparam[1] := length;
   gparam[2] := angle;
   gcall(2,2);
END;

PROCEDURE turnby(angle:INTEGER);
BEGIN
   gparam[1] := angle;
   gcall(3,1);
END;

PROCEDURE mode(mode:INTEGER);
BEGIN
   gparam[1] := mode;
   gcall(4,1);
END;

PROCEDURE fill;
BEGIN
   gcall(5,0);
END;

PROCEDURE colour(col:INTEGER);
BEGIN
   gparam[1] := col;
   gcall(6,1);
END;

PROCEDURE dot(x,y,col:INTEGER);
BEGIN
   gparam[1] := x;
   gparam[2] := y;
   gparam[3] := col; 
   gcall(9,3);
END;

PROCEDURE range(x,y:INTEGER);
BEGIN
   gparam[1] := x; gparam[2] := y;
   gcall(10,2);
END;

PROCEDURE centre(x,y:INTEGER);
BEGIN
   gparam[1] := x;
   gparam[2] := y;
   gcall(11,2);
END;

PROCEDURE moveby(length:INTEGER);
BEGIN
   gparam[1] := length;
   gcall(12,1);
END;

PROCEDURE draw(x,y,col:INTEGER);
BEGIN
   gparam[1] := x;
   gparam[2] := y;
   gparam[3] := col;
   gcall(13,3);
END;

PROCEDURE drawby(length,col:INTEGER);
BEGIN
   gparam[1] := length;
   gparam[2] := col;
   gcall(14,2);
END;

PROCEDURE background(colour:INTEGER);
BEGIN
   gparam[1] := colour;
   gcall(15,1);
END;

PROCEDURE wipe;
BEGIN
   gcall(16,0);
END;

PROCEDURE axes(xinc,yinc:INTEGER);
BEGIN
   gparam[1] := xinc;
   gparam[2] := yinc;
   gcall(17,2);
END;

PROCEDURE place(x,y:INTEGER);
BEGIN
   gparam[1] := x;
   gparam[2] := y;
   gcall(18,2);
END;

PROCEDURE radians;
BEGIN
   gcall(19,0);
END;

PROCEDURE degrees;
BEGIN
   gcall(20,0);
END;
 
PROCEDURE circle(x,y,rad:INTEGER);
BEGIN
   gparam[1] := x;
   gparam[2] := y;
   gparam[3] := rad;
   gcall(22,3);
END;

PROCEDURE dump;
BEGIN
   gcall(23,0);
END;

{  TEXT  } 

PROCEDURE  xtext( straddr,len:INTEGER);
BEGIN
   putb(grstrm,16);
   putb(grstrm,7);
   putb(grstrm,len);
   putb(grstrm,0);
   putblk(grstrm, straddr,len);
END;

{NB - strings to be plotted must be EXACTLY the length stated &}
{     padded to length with spaces if necessary. Turbo Pascal  }
{     will allow dynamic strings, but not HISOFT               }

PROCEDURE text10( str:string10);
BEGIN
   xtext( ADDR(str),10)
END;

PROCEDURE text20( str:string20);
BEGIN
   xtext( ADDR(str),20)
END;

{ write other procedures if other standard lengths required }

{  PEN  }

FUNCTION pen(n:INTEGER):INTEGER;
BEGIN
  gparam[1] := n;
  gcall(8,1);
  getstr(grstrm,ADDR(fpstore),6);
  pen := unfloat;
END;

 
{STARTUP and CLOSEDOWN}

PROCEDURE editon;  { switch on the editor device 18 }
BEGIN
   close(1);
   open(out,1,18,'      ');
   putc(1, CHR(6)); dev18 := TRUE;
END;


PROCEDURE ENDGRAPHICS;
BEGIN
   close(grstrm); editon; 
END;

PROCEDURE errorexit;
BEGIN
   ENDGRAPHICS;
   WRITELN('IO Error ', ORD(register[A]):3);
   HALT;
END;

PROCEDURE GRAPHICS(device,split:INTEGER);
VAR size: string6; 
BEGIN 
   IF (device <> 11) AND (device <> 33) THEN BEGIN
      WRITELN('Graphics Device Must be 11 or 33');
      HALT;
   END;

   grdev := device; grstrm := 5;
   IF (device = 11) THEN  BEGIN          { open the linked stream   }
      close(1); open(out,1,0,'120   ');  { 120 seems to be max poss }
   END
   ELSE BEGIN				 { device 33 needs no linked strm}
      IF (split > 0) THEN BEGIN          { if we keep device 18 open }
           size := '80    ';             { as editor on stream 1, then}
           dev18:= TRUE;                 { the room for graphics is  } 
      END				 { much reduced. Experiment! } 
      ELSE BEGIN                       
           size := '180   ';
           close(1);
           dev18 := FALSE;
      END;
      open(out,grstrm,grdev,size);
   END;
   IF oserror THEN errorexit
   ELSE BEGIN
      IF (device = 11) THEN BEGIN
        close(grstrm); open(out,grstrm,grdev,'#1n150'); 
        IF oserror THEN errorexit
        ELSE dev18 := FALSE;
      END
   END;
   background(1); wipe; range(200,150);
   putc(1,CHR(6));
END;

