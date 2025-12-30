(*****************************************************)
(*  GRAPH.INC  -  module for graphics on NewBrain    *)
(*  NB  must also have SYS.INC and PIO.INC,          *)
(*      same limitations - Highest prog addr DFFF !  *)
(*****************************************************)



Const GraphicsEscape = 16;

Type  fpstring = string[6];
      ParamStack = array[1..3] of integer;
      GrCode   = 0..23;
      xypos    = integer;
      ColourType  = 0..3;
      ModeType    = 0..3;
      AngleType  = integer;

Const
      GrStream : byte = 5;         (* could be variables     *)
      GrDevice : byte = 33;        (* but these Turbo typed  *)
      GrSize   : Pstring = '85';   (* constants are efficient*)

Var   Osfpstore: fpstring;
      GrParams : ParamStack;
      TextStr  : string[255];

(********************************************************)
(*  We need NewBrain floating-point.  A 16-bit +ve      *)
(*  integer in var num is converted to six-byte fp      *)
(*  and held in OSfpstore which is a string. This       *)
(*  can then be output by OSputStr.                     *)
(* first a procedure to float a 16-bit positive integer *)
(* - the basic graphics requirement.                    *)
(********************************************************)

Procedure _floatInt(num:integer);
Begin
   Inline( $ED / $5B / num /        (* LD DE, num    *)
           $CD / $FB / $F4 /        (* CALL CPMZCALL *)
           $28 /                    (* DEFB ZFLT     *)
           $21 / Osfpstore /        (* LD HL fpstore *)
           $36 / 6 /                (* LD (HL),6     *)
           $23 /                    (* INC HL        *)
           $CD / $FB / $F4 /        (* CALL CPMZCALL *)
           $2D )                    (* DEFB  ZSTF    *)
End;

(* Osfpstore now holds Exp byte + 5 fractions bytes  *)
(* The exponent increments by 2 always and odd values*)
(* are negative. Look after this at high level.      *)

Function floatInt(n:integer):fpstring;
Var
      i:integer;
Begin
    _floatInt(abs(n));
    If (n < 0) then
       Osfpstore[1] := succ(Osfpstore[1]);
    floatInt := Osfpstore;
End;
{}

(* procedure to send a floated value to (graphics) stream *)

Procedure OsPutfp(stream:byte; n:integer);
Begin
    OsPutStr(stream,floatInt(n));
End;

(* since this isn't a conveniently 'stacked' language like Forth *)
(* each type of graphics command needs a different basic routine *)
(* based on number of parameters sent.   For extra speed this    *)
(* could well be a big 'InLine' procedure - we'll see.           *)

Procedure  GrPrim(Code:GrCode;params:integer);
Var i:integer;
Begin
   OsPut(GrStream,GraphicsEscape);
   OsPut(GrStream,Code);
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
{}

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

(* FILL *)   { NB not enough memory to use this really ! )

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

{}

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

{}

(* CIRCLE *)

Procedure  circle(x,y,centre: xypos);
Begin
   GrParams[1] := x;
   GrParams[2] := y;
   GrParams[3] := centre;
   GrPrim(22,3)
End;

(* DUMP  *)   { NB - useable with OSget, but needs OSgetStr (not done!) }

Procedure  dump;
Begin
   GrPrim(23,0)
End;

(* Text, and the Pen functions need special handling, just text for now *)

(*  GTEXT  *)

Procedure  gText(str: Pstring);
Var i:integer; ch:byte;
Begin
   OsPut(GrStream,GraphicsEscape);
   OsPut(GrStream,7);
   OsPut(GrStream,ord(Str[0]));
   OsPut(GrStream,0);
   for i := 1 to ord(str[0]) do begin
       ch := ord( str[i]);
       OsPut(GrStream,ch);
   end
End;

(*            General start-up and shut-down procedures.          *)
(*  Remember, GrSize can be redeclared before GraphicsBegin.      *)

Procedure  GraphicsBegin;
Begin
   OsClose(1);    { close device 18 stream 1 - remember to reopen !}
   OsClear;       { close all streams from 5 upwards               }
   OsOpen(_OUT,GrStream,GrDevice,GrSize);
End;

Procedure GraphicsEnd;
Begin
   wipe;
   OsClear;
   OsOpen(_OUT,1,18,''); { open device 18 stream 1 again }
   OsPut(1,6)
End;

(*************************************************************************)
(*  NB  OSputStr is clumsy - it should really be called OSputBlk because *)
(*     it uses type <byte> to allow numbers. If we did this then another *)
(*     version of OSputStr could easily use type <char> for quicker text *)
(*     there will then be two complementary OSget Functions.             *)
(*************************************************************************)

(* EOF *)
