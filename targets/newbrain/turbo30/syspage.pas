
(*****************************************************)
(*                 SYSPAGE.PAS                       *)
(*  This program uses the system-page functions in   *)
(*  SYS.PAS for demonstration purposes.              *)
(*  It also demonstrates how to access the operating *)
(*  system zcalls via the location CPMZCALL followed *)
(*  by the zcode itself. The procedure PROMPT shows  *)
(*  this - and how to output without BDOS (naughty!) *)
(*                                                   *)
(*  Please communicate improvements and extensions   *)
(*  of these primitives                              *)
(*                                                   *)
(*  Gordon Crosse  Brants Cottage,  Wenhaston        *)
(*                 HALESWORTH, Suffolk. IP19 9EX.    *)
(*       Tel  Blythburgh (0502 70) 354               *)
(*****************************************************)

{$I WRITEHEX.INC}           (*  print values in HEX  *)
{$I BITS.INC}               (*  testbit function     *)
{$I SYS.INC }               (*  system-page access   *)
{$I CLOCK.INC}              (*  write the time       *)

Procedure clearprompt;            { clear LED display }
Begin
    prompt('                ');   { 16 spaces}
End;

Procedure wait;
Begin
  writeln;
  writeln('*** Any Key ***');
  Repeat Until keypressed
End;

{}

(********************************************************************)
(*  The following Procedures are just demonstrations of principle.  *)
(*  I haven't worked very hard at making sure that the information  *)
(*  they show is either accurate, or properly interpreted.          *)
(********************************************************************)

Procedure clock;                           (*  locations 69H,6AH,6BH *)
Var thours,tmins,tsecs,hours,mins,secs,ticks,time:integer;
    tt:real;
Begin
  ClrScr;
  write(#5); {cursor off}
  writeln('                      THE   CLOCK');
  writeln;
  writeln('- address -      - elapsed time -      - since  switchon -');
  writeln('$69.$6A.$6B      Hrs   Mins  Secs       Hrs    Mins   Secs');
  writeln;
  hours := 0; mins := 0; secs := 0; time := 0;
  repeat
    write(#28);
    ticks := (SysGetByte($6B) + SysGetByte($6A) shl 8) div 50;
    If (ticks <> time) then begin
       time := ticks;
       secs := secs + 1;
       If (secs >= 60) then begin
          secs := 0; mins := mins + 1;
       end;
       If (mins >= 60) then begin
          mins := 0; hours := hours +1;
       end;
    end;
    write(SysGetByte($69):2);
    write(SysGetByte($6A):4);
    write(SysGetByte($6B):4);
    write('        ', hours :2,'  ',mins :4,'  ',secs :4,'         ');
    timestr(8,8);
  Until keypressed;
  writeln;
  write(#6);  {cursor on}
  wait
End;

{}

Procedure Vtable;
var t,limit,i,ad : integer;
Begin
    ClrScr;
    writeln('         Table of locations of Video-Areas & lengths');
    writeln('         -------------------------------------------');
    writeln('         address      length      address     length');
    t:= $1600;
    limit := $167F;
    i := 1;
    writeln;
    while (t <= limit) do begin
       write(i:6,' :  ');
       writehex(SysGetByte(t+1),2);
       writehex(SysGetByte(t),2);
       write('     ');
       write(SysGetByte(t+2)+(SysGetByte(t+3) shl 8):6);
       t := t+4; i := i+1;
       If odd(i) then writeln;
    end;
    writeln;
    wait
End;

{ SCREEN demonstrates use of cursor position & character reading }

Procedure Screen;
label finish;
var ad,x,y,l, cpos:integer; cc,ch:char;
Begin
   l:= 128;
   ClrScr;
   ad := SysGetByte($5A) + (SysGetByte($5B) shl 8);  (* grab address of cursor at 0,0 *)
   gotoXY(1,18);
   writeln('The Cursor Position can be read & the Character at Cursor.');
   writeln('----------------------------------------------------------',^M);
   writeln('There are ',l,' cols per display line');
   writeln('TRY moving the Cursor - a NEWLINE will show its position, ESC will exit');
   repeat
     repeat
        read(kbd,ch);
        If (ch = #27) then goto finish;     (* stick with old cursor codes *)
        If (ch = #12) then ch := #30;
        If (ch = #26) then ch := #12;
        If (ch <> #13) and (ch <> #31) then write(ch);
     until (ch = #13);
     cc := chr(SysGetByte($F));                  (*  character at cursor        *)
     cpos := SysGetByte($5A) + (SysGetByte($5B) shl 8)- ad;
     gotoXY(1,23);
     ClrEol;
     write('Curpos = ',cpos,'    character at cursor is  ', cc);
     gotoXY(1 + cpos mod l,1 + cpos div l);
   until ch = #27;
   finish:
   wait
End;

{}

Procedure Devtable;
Var i,loc,count:integer;
    heading1,heading2 :string[80];
Begin
   ClrScr;
   heading1 :='                 DEVICE-DRIVER TABLE'+^M+^J;
   heading2 :='                 -------------------'+^M+^J;
   writeln(heading1,heading2);
   writeln(' The Slot 4 Pagenumber  then the  location when in the Map');
   writeln;
   count :=1;
   loc := $E00;
   for i := 0 to 254 do begin
      If (SysGetByte(loc+i+256) > 0) then begin
            write('    ',i:4,'    ');
            writehex(SysGetByte(loc+i+256),2);
            writehex(SysGetByte(loc+i),2);
            write('   ');
            writehex(SysGetByte(loc+i+2*256)+SysGetByte(loc+i+3*256) shl 8,4);
            write('   ');
            If not odd(count) then writeln;
            If (count mod 30 = 0) then begin
                writeln;
                wait;
                ClrScr;
                writeln(heading1,heading2,^M,^J);
            end;
        count := count +1;
      end
   end;
   writeln;
   wait
End;

{}

(* STATUSTABLE  -  look at each stream in the table and show bits set *)

Procedure Statustable;
Var st,i,j:integer;
Begin
   ClrScr;
   writeln('                     STREAM - STATUS');
   writeln('                     ---------------'+^M+^J);
   for i := 0 to 255 do begin
       st := SysGetByte(i+$600);
       If (st <> 0) then begin
          writeln;
          write('stream ', i,' :   ');
          for j := 0 to 7 do begin
              If testbit(j,st) then write (' 1  ')
              else write(' 0  ')
              end
       end
   end;
   writeln;
   wait
End;

{ STREAM-TABLE shows object-number for each open stream}

Procedure Streamtable;
Var i,k:integer;
Begin
  ClrScr;
  writeln( 'STREAM - TABLE':48);
  writeln( '--------------':48);
  for i := 0 to 255 do begin
      k :=  SysGetByte($B00+i);
      If (k > 0) then begin
         write('#',i:3,'  - object no. is  ');
         k := SysGetByte($B00 + i + $100) shl 8 + k;
         writeln(k);
      end
  end;
  writeln;
  writeln('All other Streams are closed');
  wait;
End;

{}

Procedure Regiontable;
Var i,loc:integer;
Begin
   ClrScr;
   writeln('                          REGION - TABLE');
   writeln('                          --------------'+^M+^J);
   writeln('   (1) first page  (2) slot 4 Page-number (3) location of Manager');
   loc := $16A0;
   i := 0;
   while loc <= $16FF do begin
       write(i:2,' :   ');
       writehex(SysGetWd(loc),4);
       write('              ');
       writehex(SysGetWd(loc+2),4);
       write('              ');
       writehex(SysGetWd(loc+4),4);
       writeln;
       loc := loc+6;
       i := i+1
   end;
   wait
End;

{}

(*  main program loop  *)


Var option:char;

Begin
   repeat
      ClrScr;
      writeln(' Try One of these:');
      writeln;
      writeln(' Clock.......type T');
      writeln;
      writeln(' Reset Clock.type Z');
      writeln;
      writeln(' StreamTable.type #');
      writeln;
      writeln(' VideoTable..type V');
      writeln;
      writeln(' DeviceTable.type D');
      writeln;
      writeln(' Cursor......type C');
      writeln;
      writeln(' RegionTable.type R');
      writeln;
      writeln(' StatusTable.type S');
      writeln;
      writeln(' Finish......type Q');
      writeln;
      write('       - -',#8,#8);
      prompt('CHOOSE OPTION   ');
      read(kbd,option);
      clearprompt;
      case option of
         'T','t': begin
                    prompt(' THE CLOCK      ');
                    clock;
                  end;
         'V','v': begin
                    prompt(' VIDEO TABLE    ');
                    Vtable;
                  end;
         'D','d': begin
                    prompt(' DEVICE DRIVERS ');
                    DevTable;
                  end;
         'C','c': begin
                    prompt(' CURSOR POSITION');
                    Screen;
                  end;
         'R','r': begin
                    prompt(' REGION-TABLE   ');
                    Regiontable
                  end;
         'S','s': begin
                    prompt(' STREAM-STATUS  ');
                    statustable;
                  end;
         '3','#': begin
                    prompt(' STREAM-TABLE   ');
                    streamtable
                  end;
         'Q','q': begin
                    prompt(' GOODBYE        ');
                    halt;
                  end;
         'Z','z': begin
                    zerotime;
                    prompt(' RESETTING CLOCK');
                    wait
                  end;
      end;
   until (true=false)
End.
