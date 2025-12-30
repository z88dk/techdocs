(*  writehex   -  output  number in hex      *)
(*                n = number, d = digits     *)

{$A-}
Const
        hexchar : array[0..15] of char  =
                  ('0','1','2','3','4','5', '6','7',
                   '8','9','A','B','C','D','E','F');
Type
        str8 = string[8];

procedure writehex( n,d:integer);
Begin
   If d>1 then writehex (n shr 4, d-1);
   write( hexchar[ n and 15] )
End;

Function  dec2hex(n,d:integer):str8;
Var str:str8;
Begin
   str := '';
   while (d > 0) do begin
      str := hexchar[n and 15] + str;
      d := d-1;
      n := n shr 4
   end;
   dec2hex := str;
End;

Function  hex2dec(str:str8): integer;
Var i,n,sum: integer; error: boolean;
Begin
   sum := 0;
   error := false;
   for i := 1 to length(str) do begin
       n := pos(str[i],hexchar)-1;
       If(n < 0) then error := true;
       sum := sum*16+ n
   end;
   If error then hex2dec := 0
   else hex2dec := sum
End;

