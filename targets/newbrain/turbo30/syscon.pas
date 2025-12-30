
{ constants for paging routines }

	{ use slot 5 as a temporary home } 
        temp = 5;      
        { set the address of first byte  }
        tslotcode = #A000;

        { the essential system addresses }

        cpm0  = #F8AE;  { first location in cpm of spn store}
        sysp0 = #F8C9;  { contains spn of absent systempage }
        s0    = #8B;    { addr of spn store in systempage   }

	pagereg = 2;    { the port used to switch pages     }

        { a couple of z80 mnemonics for INLINE code}
      
        DI = #F3;   EI = #FB;

{ constants for zcall routines }
        
        ZADDR = #DF00;    { addr to load .ext file }
  	zoutput = #30;    zinput   = #31;
	zopenin = #32;    zopenout = #33;
        zclose  = #34;    zflt     = #28;
        zstf    = #2D;    zldf     = #2B;
        zround  = #29;
        zblkin  = #3C;    zblkout  = #3D;
       
        in = 0; out = 1;

