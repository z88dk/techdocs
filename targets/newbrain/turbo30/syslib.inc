(***************************************************************)
(*         TURBO PASCAL  SYSTEM-LIBRARY for NEWBRAIN           *)
(*   a) paged memory                                           *)
(*   b) zcalls (and general m/c interface)                     *)
(*   c) pios interface (open close get put etc)                *)
(***************************************************************)

Const  CPM0    = $F8AE;
     VIDEOTOP  = $9F;
       vtemp   = 5;      {the temporary slots to house systempage}
       temp    = 5;      {or videopage. Need not be the same.    }
       vslot   = $A0;    {i.e. vtemp*32 }
       tslot   = $A0;    {i.e. temp*32  }
     vslotcode = $A000;  {i.e. vslot shl 8}
     tslotcode = $A000;  {i.e. tslot shl 8}
       S0      = $A08B;  {i.e. with offset to temp slot}
       pagereg = 2;

       pstore  = $D00;

       { for inline() code }
       DI = $F3;  EI = $FB;

{zcalls for maths & i/o}
       zfix    = $27;  zflt     = $28; zround  = $29; zinp     = $2A;
       zldf    = $2B;  zout     = $2C; zstf    = $2D;

       zoutput = $30;  zinput   = $31; zopenin = $32; zopenout = $33;
       zclose  = $34;                  zbrktest= $36;
       zklook  = $3A;  zblkin   = $3C; zblkout = $3D;
       zrdbyte = $41;  zrdint   = $42; zrdnsp  = $43;

Type   paramstr = string[255];
       SpnArray = array[0..7] of integer;

Var    cpmSpn: SpnArray absolute CPM0;
       s0spn:  SpnArray absolute S0;
       sysp0:  integer  absolute $F8C9;
       vpage:  byte;
    vidstart:  integer;

Procedure pageIn(slot,page:byte);
Begin
   port[(slot shl 8) +pagereg] := page;
End;

{ Inform O/S of the page switch by updating S0..S7 }
{ This assumes that the systempage is in tslot.     }

Procedure setSlot(slot,page:byte);
Begin
   s0spn[slot div $20] := (slot shl 8)+page;
End;

{ Put the system page in a temporary slot }

Procedure sysIn;
Begin
    inline(DI);
    pageIn (tslot,lo(sysp0));
    setSlot(tslot,lo(sysp0));
    inline(EI);
End;

{ restore the temporary slot }

Procedure sysOut;
var slot,page:byte;
Begin
    slot := hi(cpmSpn[temp]);
    page := lo(cpmSpn[temp]);
    inline(DI);
    setSlot(slot,page);
    pageIn (slot,page);
    inline(EI);
End;

{ 'SYSPEEK' }
Function sysgetb(addr:integer):byte;
Begin
    sysIn;
    sysgetb := mem[tslotcode+addr];
    sysOut;
End;

Function sysgetc(addr:integer):char;
Begin
    sysgetc := chr(sysgetb(addr));
End;

{ 'SYSPOKE' }
Procedure sysputb(addr:integer;value:byte);
Begin
   sysIn;
   mem[tslotcode+addr] := value;
   sysOut;
End;

Procedure sysputc(addr:integer; value:char);
Begin
    sysputb(addr, ord(value));
End;

{ The word-length equivalents }

Function sysgetWd(addr:integer):integer;
Begin
    sysIn;
    sysgetWd := mem[tslotcode+addr] + mem[tslotcode+addr+1] shl 8;
    sysOut;
End;

Procedure sysputWd(addr:integer; value:integer);
Begin
    sysIn;
    mem[tslotcode+addr]   := lo(value);
    mem[tslotcode+addr+1] := hi(value);
    sysOut;
End;

{ A similar set of procedures can handle a video page}
{ videoInit - MUST be called before anything else!   }

Procedure videoInit;
Begin
    vpage := sysgetb(VIDEOTOP);    { the only page available! }
End;

Procedure vpageIn;
Begin
    inline(DI);
    pageIn(vslot,vpage);
    setslot(vslot,vpage);
    inline(EI);
End;

{ vpageOut allows vslot & tslot to be the same - or not. }

Procedure vpageOut;
var slot,page:byte;
Begin
  If (vslot = tslot) then
    sysOut
  else begin
    slot := hi(cpmSpn[vtemp]);     { establish what should be in map}
    page := lo(cpmSpn[vtemp]);
    sysIn;                         {bring in system page in order to}
    inline(DI);                    {be able to reset the slot.      }
    setSlot(slot,page);
    pageIn(slot,page);             {now bring back proper page      }
    inline(EI);
    sysout;
  end;
End;

Function vpeek(addr:integer):byte;
Begin
    vpagein;
    vpeek := mem[(vslot shl 8) + addr];
    vpageOut;
End;

Procedure vpoke(addr:integer; value:byte);
Begin
    vpagein;
    mem[(vslot shl 8)+addr] := value;
    vpageOut;
End;

{ some useful functions by peeking the system page }

Const Sstart = $8004;

function curpos:integer;
Begin
   curpos := sysgetWd($5A);
End;

function hpos:integer;
Begin
   hpos := 1+(curpos - sstart) mod 128;
End;

function vpos:integer;
Begin
   vpos := 1+(curpos - sstart) div 128;
End;

function curchar:char;
Begin
   curchar := sysgetc($0F);
End;


(***********************************************************)
(* ASM - an alternative to inline &/or external procedures *)
(* ZCALL - make NewBrain Zcalls                            *)
(***********************************************************)

Type  codestr   = string[255];
      regsize   = (single,double);

      regvec = record
             case regtype: regsize of
                  single : ( A,C,B,E,D,L,H:byte);
                  double : ( Af:byte;
                             BC,DE,HL:integer);
             end;

{ the global CODE should be set to whatever code you wish to call }
{ &  should always end with a RET.  The first byte (length) will  }
{ be set to 0 by the ASM function, and registers may be set by    }
{ assignment to  registers. The point of this arrangement is that }
{ it is easy to modify a code segment by assigning to CODE[ ].    }
{ see zcall below as a sample.                                    }

Var   registers: regvec;
      CODE:codestr;
      osresult:byte;

Function ASM:integer;  {return value of the AF register}
var flags:integer;
Begin
    CODE[0] := chr(0);
    Inline(
            $DD/ $21/ registers/        (* LD   IX,registers     *)
            $DD/ $7E/ $01/              (* LD   A,(IX+1)         *)
            $DD/ $4E/ $02/              (* LD   C,(IX+2)         *)
            $DD/ $46/ $03/              (* LD   B,(IX+3)         *)
            $DD/ $5E/ $04/              (* LD   E,(IX+4)         *)
            $DD/ $56/ $05/              (* LD   D,(IX+5)         *)
            $DD/ $6E/ $06/              (* LD   L,(IX+6)         *)
            $DD/ $66/ $07/              (* LD   H,(IX+7)         *)
            $CD/ CODE /                 (* CALL CODE             *)
            $F5/                        (* PUSH AF               *)
            $E1/                        (* POP  HL               *)
            $22/ flags);                (* LD   (flags),HL       *)
    asm := flags;
End;

{ASMx  works just the same but stores values of all registers after }
{its CALL.  These can be inspected by looking at registers.BC etc.  }

Function ASMx:integer;  {return value of the AF register}
var flags:integer;
Begin
    CODE[0] := chr(0);
    Inline(
            $DD/ $21/ registers/        (* LD   IX,registers     *)
            $DD/ $7E/ $01/              (* LD   A,(IX+1)         *)
            $DD/ $4E/ $02/              (* LD   C,(IX+2)         *)
            $DD/ $46/ $03/              (* LD   B,(IX+3)         *)
            $DD/ $5E/ $04/              (* LD   E,(IX+4)         *)
            $DD/ $56/ $05/              (* LD   D,(IX+5)         *)
            $DD/ $6E/ $06/              (* LD   L,(IX+6)         *)
            $DD/ $66/ $07/              (* LD   H,(IX+7)         *)
            $CD/ CODE /                 (* CALL CODE             *)
            $DD/ $77/ $01/              (* LD   (IX+1),A         *)
            $DD/ $71/ $02/              (* LD   (IX+2),C         *)
            $DD/ $70/ $03/              (* LD   (IX+3),B         *)
            $DD/ $73/ $04/              (* LD   (IX+4),E         *)
            $DD/ $72/ $05/              (* LD   (IX+5),D         *)
            $DD/ $75/ $06/              (* LD   (IX+6),L         *)
            $DD/ $74/ $07/              (* LD   (IX+7),H         *)
            $F5/                        (* PUSH AF               *)
            $E1/                        (* POP  HL               *)
            $22/ flags);                (* LD   (flags),HL       *)
    asmx := flags;
End;

{ analyse flags result with functions like carry }

function carry(flag:byte):boolean;
Begin
    carry := (flag and 1 = 1);
End;

{ note different notation for m/c bytes since we are assigning to a}
{ string. '+' makes a useful separator.                            }

Procedure zcall(func:byte);
var flag:integer;
Begin
   CODE := #$CD#$FB#$F4+       { CALL CPMZCALL  }
           #$00+               { DEFB DUMMY     }
           #$C9;               { RET            }
   CODE[4] := chr(func);       { now define the dummy }
   flag := ASMx;               { x - because regs needed later}
   if carry(lo(flag)) then     { if error - return number }
        osresult:= hi(flag)
   else osresult := 0;         { else 0 result = ok}
End;

{ NB  it would be possible to make zcall more intelligent - e.g. if}
{ sets of zcalls needing/not needing subsequent examination of registers}
{ were used, then zcall could decide whether to call ASM or ASMx   }

{THE MAIN PIOS-INTERFACE}

const  inp:  byte = 0;
       outp: byte = 1;


function OSerror:boolean;
Begin
   OSerror := (OSresult <> 0);
   OSresult := 0;
End;

procedure IOerror(n:byte);
Begin
  writeln;
  writeln('+++ IO-ERROR ',n,' +++');
End;

procedure sysStore( str:paramstr);
var i:integer; ch:char;
Begin
     for i := 1 to length(str) do begin
       ch := str[i];
       sysputc(pstore+i-1, ch);
     end;
End;

procedure osOpen(mode,stream,device:byte; params:paramstr);
var i:integer;
Begin
   sysStore(params);
   with registers do begin
        A := device;
        D := 0;
        E := stream;
       BC := length(params);
       HL := pstore;
   end;
   if (mode=inp) then
        zcall(zopenin)
   else zcall(zopenout);
   if oserror then IOerror(registers.A);
End;

procedure osClose(stream:byte);
Begin
   registers.E := stream;
   zcall(zclose);
   Osresult := 0;  { no errors for this! }
End;

procedure osClear;  {close all non-cpm streams}
var i: integer;
Begin
    for i := 6 to 255 do osClose(i)   { 5 is used by softkeys! }
End;

procedure osPutb(stream,b:byte);
Begin
  registers.A := b;
  registers.E := stream;
  zcall(zoutput);
End;

procedure osPutc(stream:byte;c:char);
Begin
  osPutb(stream,ord(c))
End;

Function osGetb(stream:byte):byte;
Begin
  registers.E := stream;
  zcall(zinput);
  if (OSresult = 0) then
     osGetb := registers.A
  else osGetb := 0;
End;

function osGetc(stream:byte):char;
Begin
  osGetc := chr(osGetb(stream))
End;

procedure osPuts(stream:byte; str:paramstr);
Begin
   sysStore(str);
   with registers do begin
      BC := length(str);
      HL := pstore;
       E := stream;
   end;
   zcall(zblkout);
End;

{ osGets  can be similarly implemented. Remember that the string addr }
{ must always be visible when systempage is in - i.e. either use system}
{ page itself, or ensure it is not in slots 0 or 7}
