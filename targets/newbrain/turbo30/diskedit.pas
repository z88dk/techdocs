
(*  DISKEDIT  - simple  disk sector editor with on-screen editing *)


Const
   MAXSEC = 39; MAXTRACKS = 159;
   firstX = 5; lastX = 50; firstY = 4; lastY = 11;
   firstAscii = 55;

Const
   Hx : array[1..16] of integer
   = (5,8,11,14,17,20,23,26,29,32,35,38,41,44,47,50);
   Hy : array[1..8] of integer
   = (4,5,6,7,8,9,10,11);

   ESC : char = ^[ ;  DEL:   char = #127;
   LEFT: char = ^H ;  RIGHT: char = ^L;
   UP:   char = ^K ;  LF:    char = ^J;
   NEWLINE : char = ^M;  HOME : char = #30;

   CurOff: char = ^E;  CurOn : char = ^F;

   Header: string[80]
   = '    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F     0123456789ABCDEF';

Type
   SectorStore = Array[1..8,1..16] of byte;
   Str2 = string[2];

Var
   Buffer,BackUp: SectorStore;

   pcount,
   Xmin,
   Xmax,
   Xspacer,
   xpos,
   ypos,
   prevx,
   prevy  : integer;

   drive,
       ch : char;

   Printflag,
   Curflag,
   Asciiflag,
   Continueflag,
     done : boolean;

    driveno,
    track,
    sector,
      i,j : integer;

{$I WRITEHEX.PAS}

Procedure ClearTop;
Var i:integer;
Begin
  for i := 1 to 11 do begin
      gotoXY(1,i); clrEol
  end;
  gotoXY(1,1)
End;

Procedure ClearMenu;
var i:integer;
Begin
  gotoXY(1,13);
  for i:=1 to 11 do delLine;
End;

Procedure viewMenu;
Begin
  ClearMenu;
  writeln('VIEW - MODE':45);
  writeln('-----------':45);
  writeln('ESC - Quit   A  - toggle Ascii/Hex  C  - continuous sectors  D  - Set Drive');
  writeln('E   - Edit (either Ascii or Hex)    R  - Reset start point   U  - Undo Edit');
  writeln('   CURSORS & HOME  move around screen  Switch PRINTER on and off with ^P');
  writeln(LF, '                   Shift + Left/Right  = prev/next SECTOR');
  writeln(    '       Shift + Up/Down  OR   Control + Left/Right  = prev/next TRACK');
  writeln(LF, 'NB  AN EDITED SECTOR IS NOT WRITTEN TO DISC UNTIL ^W IS PRESSED IN VIEW-MODE');
End;

Procedure editMenu;
Begin
  ClearMenu;
  writeln('EDIT - MODE':45);
  writeln('-----------':45);
  writeln('EDIT HEX  -  Overwrite byte at cursor & press NEWLINE to confirm or ESC to end');
  writeln('         You may edit next byte immediately, or enter View-Mode to move cursor');
  writeln('EDIT ASCII - Overwrite or move cursor anywhere. Then confirm ALL changes with');
  writeln('         NEWLINE or abandon with ESC.');
  writeln(LF,' REMEMBER - Write to disc with ^W BEFORE changing display or changes are LOST');
End;

Procedure nexttrack;
Begin
   track := track +1;
   If (track > MAXTRACKS) then track := 0;
End;

Procedure Prevtrack;
Begin
   track := track -1;
   If (track < 0) then track := MAXTRACKS;
End;

Procedure nextsector;
Begin
    sector := sector+1;
    If (sector > MAXSEC) then begin
       sector := 0;
       nexttrack;
    end;
End;

Procedure prevsector;
Begin
    sector := sector -1;
    If (sector < 0) then begin
       sector := MAXSEC;
       prevtrack;
    end;
End;

Procedure ReadSector;
Begin
   Bios(9,track);
   Bios(10,sector);
   Bios(11,addr(Buffer));
   Bios(12);
   Backup := Buffer
End;

Procedure WriteSector;
Begin
   Bios(9,track);
   Bios(10,sector);
   Bios(11,addr(Buffer));
   Bios(13)
End;

Function showascii(n:byte):char;
Begin
   ch := chr(n);
   If (ch < ' ') or (ch = DEL) then ch := '.';
   showascii := ch
End;

Procedure Showbuffer;
Var row,col: integer; ch: char; done: boolean;
Begin
 done := false;
 Repeat
   ClearTop;
   If Printflag then writeln(lst,'Drive:',drive,'  Track: ',track,'  Sector: ',Sector,LF);
   write('Drive: ',drive,'   Track: ',track:2,'  Sector: ', sector:2);
   gotoXY(1,firsty-1);
   If Printflag then writeln(lst,Header);
   writeln(Header);
   for row := 1 to 8  do begin
      If Printflag then write(lst,10*(row-1):2,':  ');
      write(10*(row-1):2,':');
      for col := 1 to 16 do begin
         gotoXY(Hx[col], Hy[row]);
         If Printflag then
            write(lst,dec2hex(Buffer[row,col],2),' ');
         writehex(Buffer[row,col],2)
      end;
      gotoXY(firstAscii-1,Hy[row]);
      write('[ ');
      If Printflag then write(lst,' [ ');
      for col := 1 to 16  do begin
          ch := showascii(Buffer[row,col]);
          write(ch);
          If Printflag then begin
             If (ch >= DEL) then ch := '.';
             write(lst,ch);
          end
      end;
      writeln(' ] :',10*(row-1):2);
      If Printflag then
         writeln(lst,' ] :',10*(row-1):2);
   end;
   If Printflag then begin
      write(lst,LF,LF);
      pcount := pcount+1;
      If pcount > 5 then begin
         write(lst,^L,LF,LF);
         pcount := 0
      end
   end;
   If not continueflag then
      done := true
   else begin
      If Printflag then begin
         if keypressed then done := true
      end
      else begin
         gotoXY(1,22); write('** Any Key to Continue. ESC to stop **');
         read(kbd,ch);
         delLine;
         done := (ch = ESC)
      end;
      If not done then begin
          nextsector;
          ReadSector;
      end
    end;
 Until done;
End;

Procedure moveto(x,y:integer);
Begin
   If (x> Xmax)  then begin
          x := Xmin;
          y := y+1
   end
   else if (x < Xmin) then begin
          x := Xmax;
          y := y-1
   end;
   If (y > lasty) then y := firsty
   else If (y < firsty) then y := lasty;
   xpos := x; ypos := y;
   gotoXY(x,y);
End;

Procedure Showcursor;
Begin
  If Curflag then begin
     write(LEFT,'<',RIGHT,RIGHT,'>');
     gotoXY(xpos,ypos);
     prevx := xpos;
     prevy := ypos
  end
End;

Procedure DeleteCursor;
Begin
  If Curflag then begin
     gotoXY(prevx,prevy);
     write(LEFT,' ',RIGHT,RIGHT,' ')
  end
End;

Procedure Restore( str:str2);
Begin
            Buffer[ypos-firsty+1,xpos div 3] := hex2dec(str);
            gotoXY(firstascii+xpos div 3, ypos);
            write(Showascii(Buffer[ypos-firsty+1,xpos div 3]));
            gotoXY(xpos,ypos);
            write(str);
            gotoXY(xpos,ypos);
            showcursor;
End;

Procedure changeAscii;
Var ch:char; index:1..16;  done:boolean;
    AscBuffer: SectorStore;
Begin
   gotoXY(firstascii,1);
   write('<<  CHANGING   >>');
   moveto(xpos,ypos);
   AscBuffer := Buffer;
   done := false;
   Repeat
      index := xpos - firstascii;
      read(kbd,ch);
      If (ch = ^Z ) then ch := RIGHT;
      If (ch in [ ' '..'~']) then begin
         write(ch);
         gotoXY(Hx[index],ypos);
         write(dec2hex(ord(ch),2));
         AscBuffer[ypos-firsty+1,index] := ord(ch);
         xpos := xpos + Xspacer;
         moveto(xpos,ypos);
     end
     else If ( ch = LEFT) then begin
             xpos := xpos - Xspacer;
             moveto(xpos,ypos)
     end
     else If ( ch = RIGHT) then begin
             xpos := xpos + Xspacer;
             moveto(xpos,ypos)
     end
     else If ( ch = UP ) then begin
             ypos := ypos -1;
             moveto(xpos,ypos)
     end
     else If ( ch = LF ) then begin
             ypos := ypos + 1;
             moveto(xpos,ypos)
     end
     else If (ch = NEWLINE) then
          Buffer := AscBuffer;
     done := (ch = ESC) or (ch = NEWLINE);
  Until done;
  gotoXY(firstascii,1);
  ClrEol;
  moveto(xpos,ypos);
End;

Procedure changeHex;
var str: str2; ch:char; index:integer; done:boolean;
Begin
   gotoXY(Hx[10],1);
   write ('<<  CHANGING  >>');
   gotoXY(xpos,ypos);
   str := dec2hex(Buffer[ypos-firsty+1,xpos div 3], 2);
   index := 1;
   done := false;
   Repeat
      read(kbd,ch);
      If (ch in ['0'..'9','A'..'F']) then begin
          write(ch);
          str[index] := ch;
          If  (index=1) then index := 2
      end
      else If (ch = ^Z) then begin
            ch := RIGHT;
            If (index = 1) then begin
                   write(ch);
                   index := 2
            end
      end
      else If (ch = LEFT) and (index =2) then begin
               index := 1;
               write(ch)
      end
      else If (ch = NEWLINE) then begin
               Restore(str);
               xpos := xpos + Xspacer;
               deletecursor;
               moveto(xpos,ypos);
               showcursor;
               index := 1;
               str := dec2hex(Buffer[ypos-firsty+1,xpos div 3], 2);
      end ;
      done := (ch = ESC)
   Until done;
   Restore(str);
   gotoXY(Hx[10],1);
   ClrEol;
   gotoXY(xpos,ypos)
End;

Procedure Undo;
Begin
   Buffer := BackUp;
   Showbuffer;
End;

Procedure SetDrive;
Begin
   GotoXY(1,1);
   ClrEol;
   Write('Drive: ');
   Repeat
      read(kbd,drive);
   Until drive in ['A','B','C','a','b','c'];
   drive := UpCase(drive);
   write(drive);
   driveno := ord(drive) - ord('A');
   Bdos(14,driveno)
End;

Procedure GetTrSec;
Begin
  Repeat
     GotoXY(1,23);
     ClrEol;
     write('Track: ');
     read (track);
  Until track in [0..MAXTRACKS];
  Repeat
     GotoXY(12,23);
     ClrEol;
     write('Sector: ');
     readln(sector);
  Until sector in [0..MAXSEC];
  delLine
End;

Procedure toggleAscii;
Begin
    Asciiflag := not Asciiflag;
    If Asciiflag then begin
          deleteCursor;
          Xmin := firstAscii+1;
          Xmax := firstAscii+16;
          Xspacer :=1;
          xpos := xpos div 3 -1 + Xmin;
          Curflag := false
     end
     else begin
             xpos := Hx[xpos -firstAscii];
             Xmin := firstx;
             Xmax := lastx;
             Xspacer :=3;
             Curflag := true
     end
End;

Procedure Edit;
var ch:char; done: boolean;
Begin
   Continueflag := false;
   xpos:= Xmin; ypos := firsty;
   moveto(xpos,ypos);
   showcursor;
   Repeat
     read (kbd,ch);
     If (ch = ^L) then ch := HOME;
     If (ch = ^Z) then ch := RIGHT;

     case ch of
           ^P   : Printflag := not Printflag;
      'd','D'   : begin SetDrive; Showbuffer  end;
      'r','R'   : begin GetTrSec; ReadSector; ShowBuffer; end;
           ^W   : Writesector;
           ^Y   : begin nextsector; Readsector; Showbuffer; end;
           ^X   : begin prevsector; Readsector; Showbuffer; end;
      'c', 'C'  : continueflag := not continueflag;
      'e', 'E'  : begin
                    editMenu;
                    If not Asciiflag then
                       changeHex
                    else changeAscii;
                    viewMenu
                  end;
    'u','U'     : undo;
    ^B, ^]      : begin
                     nexttrack; ReadSector; Showbuffer
                  end;
    ^N, ^\      : begin
                     prevtrack; ReadSector; Showbuffer
                  end;
     end; {case}
     If (ch in [ 'a','A',LEFT,RIGHT, UP, LF,HOME]) then begin
         case ch of
           ^H   : xpos := xpos-Xspacer;
           ^L   : xpos := xpos+Xspacer;
           ^K   : ypos := ypos -1;
           ^J   : ypos := ypos +1;
           #30  : begin
                    xpos := Xmin;
                    ypos := firsty;
                  end;
       'a','A'  : toggleAscii;
         end {case}
     end;
     deleteCursor;
     moveto(xpos,ypos);
     Showcursor;
     done := (ch = ESC)
   Until done
End;

Procedure endrun;
Begin
    Bdos(13,0);
End;

Begin
 write(^W,^D);
 ClrScr;
 Xmin := firstx;
 Xmax := lastx;
 Xspacer := 3;
 xpos := Xmin;
 ypos := firsty;
 pcount := 0;
 Printflag := false;
 Asciiflag := false;
 Curflag := true;
 gotoXY(1,5);
 Writeln(' DISKEDIT - (c) l984 Gordon Crosse.  A Turbo-Pascal Program for NewBrain.');
 write(' ------------------------------------------------------------------------');
 SetDrive;
 GetTrSec;
 write('  Continous? y/n ');
 read (kbd,ch);
 Continueflag := (UpCase(ch)='Y');
 Repeat
   ClrScr;
   ReadSector;
   Showbuffer;
   viewMenu;
   Edit;                       { all the work done here }
   GotoXY(1,23);
   writeln('** more? - ESC to finish ** ');
   read(kbd,ch);
   done := (ch = #27);
   If not done then GetTrSec;
 Until done;
 endrun;
 write(^W,^B)
End.
