
(***************************************************)
(*  PIO.INC   access NewBrain Paged IO system     *)
(*                                                 *)
(*  NB  -  At the moment  the parameter string     *)
(*         must N O T be stored in slot 7.         *)
(*         So all programs using this module must  *)
(*         set the end address to no higher than   *)
(*         $DFFF                                   *)
(*         there must be a better way ?!           *)
(*         e.g. have a START addr limit & use an   *)
(*         absolute variable  for params           *)
(***************************************************)

Const  _OUT = 1; _IN = 0;

Type
    Pstring = string[255];

Var
    OSresult : byte;
    OSparams : Pstring;
    SPsave   : integer;

(*  NB  in  Inline statements all variable identifiers leave their ADDRESS *)

Procedure  OSclose( stream:byte);
Begin
   Inline(
          $21 /  stream /                (*  LD HL,stream  (var addr)  *)
          $5E /                          (*  LD E, (HL)                *)
          $CD / $FB / $F4 /              (*  CALL CPMZCALL             *)
          $34 )                          (*  DEFB ZCLOSE               *)
End;

(*  Close all non-cp/m streams  *)

Procedure OsClear;
Var i:integer;
Begin
   for i := 5 to 255 do OsClose(i)
End;

Procedure  openin(stream,device:byte);
Begin
   Inline( $ED / $73 / SPsave /          (*  LD (SPsave),SP             *)
           $21 / stream /                (*  LD HL, stream              *)
           $5E /                         (*  LD E, (HL)                 *)
           $16 / 0 /                     (*  LD D, 0                    *)
           $21 / device /                (*  LD HL, device              *)
           $7E /                         (*  LD A, (HL)                 *)
           $21 / OSparams /              (*  LD HL, params              *)
           $4E /                         (*  LD  C, (HL)                *)
           $06 / 0 /                     (*  LD  B, 0                   *)
           $23 /                         (*  INC HL                     *)
           $CD / $FB /$F4 /              (*  CALL CPMZCALL              *)
           $32 /                         (*  DEFB ZOPENIN               *)
           $DA / *+4/                    (*  JP  C,  $+4                *)
           $3E / 0 /                     (*  LD  A, 0                   *)
           $21 / OSresult /              (*  LD  HL, OSresult           *)
           $77 /                         (*  LD  (HL), A                *)
           $A7 /                         (*  AND A     ; clear carry    *)
           $ED / $7B / SPsave )          (*  LD  SP, (SPsave)           *)
End;
{}

Procedure  openout(stream,device:byte);
Begin
   Inline( $ED / $73 / SPsave /          (*  LD (SPsave),SP             *)
           $21 / stream /                (*  LD HL, stream              *)
           $5E /                         (*  LD E, (HL)                 *)
           $16 / 0 /                     (*  LD D, 0                    *)
           $21 / device /                (*  LD HL, device              *)
           $7E /                         (*  LD A, (HL)                 *)
           $21 / OSparams /              (*  LD HL, OSparams            *)
           $4E /                         (*  LD  C, (HL)                *)
           $06 / 0 /                     (*  LD  B, 0                   *)
           $23 /                         (*  INC HL                     *)
           $CD / $FB /$F4 /              (*  CALL CPMZCALL              *)
           $33 /                         (*  DEFB ZOPENOUT              *)
           $DA / *+4/                    (*  JP  C,  $+4                *)
           $3E / 0 /                     (*  LD  A, 0                   *)
           $21 / OSresult /              (*  LD  HL, OSresult           *)
           $77 /                         (*  LD  (HL), A                *)
           $A7 /                         (*  AND A                      *)
           $ED / $7B / SPsave )          (*  LD  SP, (SPsave)           *)
End;


Procedure  OSopen(mode,stream,device:byte; params:Pstring);
Begin
   OSparams := params;
   If (mode > 0) then openout(stream,device)
   else openin(stream,device);
   If (OSresult <> 0) then begin
      writeln;
      writeln('** IO-ERROR ', OSresult,' **')
   end
End;

(*  Now put and get bytes to/from any stream  *)

Procedure OSput(stream,char:byte);
Begin
   Inline( $21/ stream /                 (*  LD HL, stream             *)
           $5E/                          (*  LD E, (HL)                *)
           $21/ char /                   (*  LD HL, char               *)
           $7E /                         (*  LD A, (HL)                *)
           $CD / $FB /$F4 /              (*  CALL CPMZCALL              *)
           $30 /                         (*  DEFB ZOUTPUT               *)
           $DA / *+4/                    (*  JP  C,  $+4                *)
           $3E / 0 /                     (*  LD  A, 0                   *)
           $21 / OSresult /              (*  LD  HL, OSresult           *)
           $77 /                         (*  LD  (HL), A                *)
           $A7 )                         (*  AND A                      *)
End;
(*  OSresult contains 0 if ok                                           *)

Function OSget(stream:byte):byte;
Begin
   Inline( $21 / stream /                (*  LD HL,stream               *)
           $5E /                         (*  LD E, (HL)                 *)
           $CD / $FB /$F4 /              (*  CALL CPMZCALL              *)
           $31 /                         (*  DEFB ZINPUT                *)
           $4F /                         (*  LD  C,A                    *)
           $21 / OSresult /              (*  LD  HL, Osresult           *)
           $D2 / *+4/                    (*  JP  NC, $+4                *)
           $0E / 0 /                     (*  LD  C, 0                   *)
           $71 /                         (*  LD  (HL),C                 *)
           $6F /                         (*  LD  L, A                   *)
           $26 / 0 /                     (*  LD  H, 0                   *)
           $A7 )                         (*  AND A                      *)
End;
(*   Returns the byte value.  OSresult contains error, if any.          *)


Procedure OSputStr(stream:byte;str:Pstring);
Begin
   Inline( $21 / stream /                (*  LD HL, stream              *)
           $5E /                         (*  LD E, (HL)                 *)
           $21 / str/                    (*  LD HL, str                 *)
           $4E /                         (*  LD  C, (HL)                *)
           $06 / 0 /                     (*  LD  B, 0                   *)
           $23 /                         (*  INC HL                     *)
           $CD / $FB /$F4 /              (*  CALL CPMZCALL              *)
           $3D /                         (*  DEFB ZBLKOUT               *)
           $21 / OSresult /              (*  LD  HL, OSresult           *)
           $71 /                         (*  LD  (HL), C                *)
           $A7 )                         (*  AND A                      *)
End;
(*  OSresult will contain 0 for ok. Or number of bytes not ouput        *)


(* EOF *)
