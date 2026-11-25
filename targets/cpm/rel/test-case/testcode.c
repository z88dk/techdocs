//  z88dk-z80asm.exe rz88dka.asm rz88dkb.asm
//  zcc +zx -lndos -create-app testcode.c rz88dka.o rz88dkb.o

#include <stdio.h>
#include <stdlib.h>


extern void putch();
extern void PUBFN();


void putch (int c) {
	fputc_cons (c);
}


void main () {
	PUBFN();
}

