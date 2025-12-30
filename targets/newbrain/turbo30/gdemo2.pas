(***************************************************************)
(*  GDEMO2   test of graphics                                  *)
(*                                                             *)
(*  NB, most IMPORTANT - the compiler must have the END addr.  *)
(*      set to DFFF or below, and the program must be compiled *)
(*      to DISK not memory. This is to keep all variables &    *)
(*      data out of slot 7 !!                                  *)
(***************************************************************)


{$I pio.inc}
{$I graph.inc}


Procedure wait;
Begin
  Repeat Until keypressed
End;

Procedure  forwards(n:integer);
Begin
    moveby(n)
End;

Procedure  back(n:integer);
Begin
    degrees;
    turnby(180);
    moveby(n);
    turnby(-180);
End;

Procedure left(angle:AngleType);
Begin
   turnby(angle)
End;

Procedure right(angle:AngleType);
Begin
   turnby(360-angle)
End;

Procedure Penup;
Begin
   colour(0)
End;

Procedure Pendown;
Begin
   colour(1)
End;


{$A-}   (* allow recursion *)

Procedure tree(size,angle,level:integer);
Begin
   If (level > 0) then begin
      left(angle);
      forwards(size*2);
      tree(size,angle,level-1);
      back(size*2);
      right(angle*2);
      forwards(size);
      tree(size,angle,level-1);
      back(size);
      left(angle);
   end
End;



Procedure willow(size,angle,level:integer);
Begin
   GrSize := '160';
   GraphicsBegin;
   If (OSresult <> 0) then begin
       GraphicsEnd; halt;
   end;
   background(1);
   wipe;
   range(320,160);
   degrees;
   place(150,80); turn(90);
   penup; back(40);pendown;
   tree(size,angle,level);
   back(30); right(90);forwards(10);back(20);
   place(5,5); gtext('A Willow Tree?');
   place(250,5);gtext('Any key');
   wait;
   GraphicsEnd
End;

Var size,angle,level:integer;
    ch:char;

Begin
  ClrScr;
  writeln('RECURSIVE WILLOW TREE ':50);
  writeln('A GRAPHICS PROGRAM IN TURBO PASCAL':55);
  writeln(#10,#10,#13,'Any key....');
  read(kbd,ch);
  size:=10; angle := 15; level := 4;
  willow(size,angle,level);
  writeln('The parameters for that were: Size 10, Angle 15, levels 4');
  writeln('Press ESC to finish OR any other to enter your own....');
  read(kbd,ch);
  If (ch =#27) then halt;
  Repeat
      write('                    Size? ');
      readln(size);
      write('                   Angle? ');
      readln(angle);
      write('                  Levels? ');
      readln(level);
      willow(size,angle,level);
      writeln('Paramaters were ',size:3,angle:3,level:3);
      writeln('Another? Press Escape to finish');
      writeln;
      read(kbd,ch)
  Until (ch = #27)
End.
