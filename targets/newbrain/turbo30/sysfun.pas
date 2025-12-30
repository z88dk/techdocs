
{ some address-manipulation routines not built into Hisoft}

FUNCTION  hibyte(n:INTEGER):INTEGER;
BEGIN
   hibyte := ORD(PEEK (ADDR(n)+1,CHAR))
END;

FUNCTION  lobyte(n:INTEGER):INTEGER;
BEGIN
   lobyte := ORD(PEEK(ADDR(n),CHAR))
END;

FUNCTION  hichar(n:INTEGER):CHAR;
BEGIN
   hichar := PEEK(ADDR(n)+1,CHAR)
END;

FUNCTION  lochar(n:INTEGER):CHAR;
BEGIN
   lochar := PEEK(ADDR(n),CHAR)
END;

