{  - load an external code-file to given address }

{ assumes sysfile declared as FILE OF CHAR }

PROCEDURE loadproc(name:string14; addr:INTEGER);
VAR I:INTEGER; CH:CHAR; size:INTEGER; 
BEGIN
   RESET(sysfile,name);
   READ(sysfile,CH); 	 
   size := ORD(CH);
   FOR I := 0 TO size-1 DO BEGIN
       READ(sysfile,CH);
       POKE(addr+I,CH);
   END;
{   WRITELN(name, '  Loaded at ',ZADDR:4:H,' ',size:3,' bytes'); }
END;

{ machine code external procedures should start with a byte containing
  the length of the code. This procedure should then be called early in
  the main program to load it to the proper address. File type .EXT is
  suggested rather than .COM to prevent inadvertent running of the code.
  Make sure that the code is relocateable, or that proper offsets are
  provided for absolute jumps or calls, or that .PHASE nnnn  is used if
  running MACRO-80.  See source of ZCALLCDE.ASM for sample }
 
