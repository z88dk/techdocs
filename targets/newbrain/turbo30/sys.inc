(*  SYS.INC - module to access NewBrain paged-memory   *)
(*     SysGetByte, SysPutByte, SysGetWd, SysPutWd      *)
(*     Curpos, CurX, CurY, Curchar.                    *)

Const   TEMP= $60;  ScrTop = $8004;

Type
   String16 = string[16];

Var
   CpmSlot : array[0..7] of integer  absolute  $F8AE;
   sysp0   : integer  absolute $F8C9;


Procedure TempPageIn( slotstore:integer);
Begin
   Inline($2A/slotstore/      {LD HL, (slotstore)     }
          $06/TEMP/           {LD B,  TEMP            }
          $0E/$02/            {LD C,  PAGEREG         }
          $F3/                {DI                     }
          $ED/$69/            {OUT (C),L              }
          $FB)                {EI                     }
End;

Procedure PageIn(slotstore:integer);
Begin
   Inline( $2A/slotstore/
           $44/               {LD B,H                 }
           $0E/$02/
           $F3/$ED/$69/$FB)   { as before             }
End;

Procedure RestoreTemp;
Begin
    TempPageIn(CpmSlot[TEMP div $20])
End;

Function  SysGetByte(offset:integer):byte;
Begin
  TempPageIn(sysp0);
  SysGetByte  := mem[ (TEMP shl 8) +offset];
  RestoreTemp
End;

Function  SysGetWd(offset:integer):integer;
var loc : integer;
Begin
  TempPageIn(sysp0);
  Loc := (TEMP shl 8) + offset;
  SysGetWd := mem[loc] + mem[loc +1] shl 8;
  RestoreTemp
End;

Procedure SysPutByte(offset:integer; value:byte);
Begin
  TempPageIn(sysp0);
  mem[(TEMP shl 8) + offset] := value;
  RestoreTemp
End;
{}

Procedure SysPutWd(offset,value :integer);
Var loc : integer;
Begin
  TempPageIn(sysp0);
  loc := (TEMP shl 8) + offset;
  mem[loc] := lo(value); mem[loc+1] := hi(value);
  RestoreTemp
End;

(*  PROMPT  sends a string to the LED display on AD models  *)

Procedure prompt(str:string16);
Begin
   Inline( $21/str/        { LD HL,str  ; i.e. string address}
           $46/            { LD B, (HL) }
           $23/            { INC HL     }
           $7E/            { LD A, (HL) ; label}
           $23/            { INC HL     }
           $1E/$04/        { LD E,4     }
           $CD/$FB/$F4/    { CALL CPMZCALL }
           $30/            { DEFB ZOUTPUT  }
           $05/            { DEC B         }
           $C2/*-10/       { JP NZ label   }
           $3E/28/         { send a final leftmargin }
           $1E/$04/        { control code to display }
           $CD/$FB/$F4/
           $30);
End;

(*  some functions & procedures for screen control - samples  *)


Function CurPos:integer;
Begin
  CurPos := SysGetWd($5A)
End;

Function CurX:integer;
Begin
   CurX := 1 + (CurPos - ScrTop) div 128
End;

Function CurY:integer;
Begin
   CurY := 1 + ( CurPos - ScrTop) mod 128
End;

Function CurChar:char;
Begin
   CurChar := chr(SysGetByte($0F))
End;


(* EOF *)

