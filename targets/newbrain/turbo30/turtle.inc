
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


(* EOF *)
