    (*****************************************************)
    (*  GRAPHLIB.INC  -  module for graphics on NewBrain *)
    (*****************************************************)

{ Graphics need several NewBrain floating-point routines. }

Type  fpstring = string[6];
      fptr = ^fpstring;

{ The store for Fp-string is a POINTER, to keep the address on the heap}
{ and not on the stack (where it can often stray into slot 7)          }

Var   Osfp : fptr;

{ convert an integer to NewBrain floating point - as a returned string}

function float(num:integer):fpstring;
Begin
     registers.DE := abs(num);
     zcall(zflt);
     registers.HL := addr(Osfp^)+1;
     zcall(zstf);
     Osfp^[0] := chr(6);
     if (num < 0) then Osfp^[1] := succ(Osfp^[1]);
     float := Osfp^;
End;

{ Function  to convert a (newbrain) fp number to an integer }

Function  unfloat:integer;
var  neg: boolean;
Begin
   if odd(ord(Osfp^[1])) then begin
      neg := true;
      Osfp^[1] := pred(Osfp^[1]);
   end
   else neg := false;
   registers.HL := addr(Osfp^)+1;
   zcall(zldf);
   zcall(zround);
   if neg then
        unfloat := -registers.DE
   else unfloat :=  registers.DE;
End;

     { procedure to send a floated value to a stream }

Procedure OsPutfp(stream:byte; n:integer);
var  junk:fpstring;
Begin
    junk := float(n);
    with registers do begin
       E := stream;
      HL := addr(Osfp^)+1;
      BC := 6;
    end;
    zcall(zblkout);
End;

(******************************************************)
(*            main   Graphics  routines               *)
(******************************************************)

Const GraphicsEscape = 16;

Type
      ParamStack = array[1..3] of integer;
      GrCode   = 0..23;
      xypos    = integer;
      ColourType  = 0..3;
      ModeType    = 0..3;
      AngleType   = integer;
      Pstring     = string[255];

Const                              (* NB  All the following values  *)
      GrStream : byte = 10;        (* could be variables & can be   *)
      GrDevice : byte = 33;        (* reassigned. But Turbo typed   *)
      GrSize   : Pstring = '85';   (* constants are more efficient. *)
      dev18    : boolean = true;   (* Flag for cp/m edit device.    *)
      split    : boolean = true;   (* use when calling GRAPHICS     *)
    nosplit    : boolean = false;
Var
      GrParams : ParamStack;

(*****************************************************************)
(* since this isn't a conveniently 'stacked' language like Forth *)
(* each type of graphics command needs a different basic routine *)
(* based on the number of parameters sent.For extra speed GrPrim *)
(* could well be a big 'InLine' procedure - we'll see.           *)
(*****************************************************************)

Procedure  GrPrim(Code:GrCode;params:integer);
Var i:integer;
Begin
   OsPutb(GrStream,GraphicsEscape);
   OsPutb(GrStream,Code);
   If (params > 0) then begin
       for i := 1 to params do
           OsPutfp(GrStream,GrParams[i]);
   end
End;

(* MOVE *)

Procedure  move(x,y : xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrPrim(0,2)
End;


(* TURN *)

Procedure  turn(angle : AngleType);
Begin
   GrParams[1] := angle;
   GrPrim(1,1)
End;

(* ARC *)

Procedure  arc(length : integer; angle:AngleType);
Begin
   GrParams[1] := length;
   GrParams[2] := angle;
   GrPrim(2,2)
End;

(* TURNBY *)

Procedure  turnby( angle:AngleType);
Begin
   GrParams[1] := angle;
   GrPrim(3,1)
End;

(* MODE *)

Procedure  mode( mode:ModeType);
Begin
   GrParams[1] := mode;
   GrPrim(4,1)
End;

(* FILL *)   { NB not enough memory to use this really ! }

Procedure  fill;
Begin
   GrPrim(5,0)
End;

(* COLOUR *)

Procedure  colour(col:ColourType);
Begin
   GrParams[1] := col;
   GrPrim(6,1)
End;

(* DOT *)

Procedure  dot(x,y: xypos; col:ColourType);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrParams[3] := col;
   GrPrim(9,3)
End;

(* RANGE *)

Procedure  range(x,y: xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrPrim(10,2)
End;

(* CENTRE *)

Procedure  centre(x,y: xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrPrim(11,2)
End;

(* MOVEBY *)

Procedure  moveby ( length:integer);
Begin
   GrParams[1] := length;
   GrPrim(12,1)
End;

(* DRAW  *)

Procedure  draw (x,y:xypos; col:ColourType);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrParams[3] := col;
   GrPrim(13,3)
End;

(* DRAWBY *)

procedure  drawby (length:integer; col: ColourType);
Begin
   GrParams[1] := length;
   GrParams[2] := col;
   GrPrim(14,2)
End;

(* BACKGROUND *)

Procedure  background(col:ColourType);
Begin
   GrParams[1] := col;
   GrPrim(15,1)
End;

(* WIPE *)

Procedure  wipe;
Begin
  GrPrim(16,0)
End;

(* AXES *)
{x and y indicate the calibration - may be 0}
Procedure  axes(x,y: xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrPrim(17,2)
End;

(* PLACE *)

Procedure  place(x,y: xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrPrim(18,2)
End;

(* RADIANS *)

Procedure  radians;
Begin
   GrPrim(19,0)
End;

(* DEGREES *)

Procedure  degrees;
Begin
   GrPrim(20,0)
End;

(* NB  flag doesn't seem to work - so skip it *)

(* CIRCLE *)

Procedure  circle(x,y,centre: xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrParams[3] := centre;
   GrPrim(22,3)
End;

(* DUMP  *)   { NB - useable with OSgetb or OSgetS  }

Procedure  dump;
Begin
   GrPrim(23,0)
End;

     { Text, and the Pen functions need special handling. }

(*  GTEXT  *)

Procedure  gText(str: Pstring);
Var i:integer;
Begin
   OsPutb(GrStream,GraphicsEscape);
   OsPutb(GrStream,7);
   OsPutb(GrStream,ord(Str[0]));
   OsPutb(GrStream,0);
   for i := 1 to ord(str[0]) do begin
       OsPutc(GrStream,str[i]);
   end
End;

(*  PEN   *)

Function pen(n:integer):integer;
var i:integer;
Begin
   GrParams[1] := n;
   GrPrim(8,1);
   for i := 1 to 6 do
       OSfp^[i] := OSgetc(GrStream);
   pen := unfloat;
End;

(********************************************************************)
(*            General start-up and shut-down procedures.            *)
(*                                                                  *)
(********************************************************************)

Procedure editoff;
Begin
   OsClose(1); dev18 := false;
End;

Procedure editon;
Begin
   OsClose(1);
   OsClose(GrStream);
   OsOpen(outp,1,18,'');
   osputb(1,6);
   dev18 := true;
End;

Procedure errorExit(str:pstring);
Begin
   If not dev18 then
     editOn;
   writeln;
   writeln(str);
   halt;
End;

Procedure  GRAPHICS(dev:byte; split:boolean);
Begin
    If not ((dev = 11) or (dev = 33)) then
       errorExit('Graphics Device must be 11 or 33');
    grDevice := dev;
    If (dev = 11) then begin
       editoff;
       Osopen(outp,1,0,'120');
    end
    else begin
       If split then grSize := '80'
       else begin
          grsize := '180';
          editoff;
       end;
       Osclose(Grstream);
       Osopen(Inp,Grstream,GrDevice,grSize);
    end;
    If OSerror then errorexit('Can''t open Graphics');
    If (dev = 11) then begin
       Osclose(Grstream);
       Osopen(outp, grstream,grDevice,'#1n150');
       If OSerror then errorExit('Can''t Open Graphics');
    end;
End;


Procedure ENDGRAPHICS;
Begin
   wipe;
   editOn;
End;

Procedure wait;    { need this for device 33 }
Var ch:char;
Begin
  read(kbd,ch);
End;

(* EOF *)
