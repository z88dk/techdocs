CZ1500 - CBM1541 disk interface user manual
(C) 2004 Luis C. Grosso

CZ1500 / CBM1541 disk interface provides a COMMODORE IEC interface for a CZ1500
A COMMODORE 1541 disk drive can be connected as a mass storage device.

It provides about 160k of disk storage per side.

THE INTERFACE MENU
--- --------- ----
RAND USR 8192 to get into the interface menu.

CZ1500 / CBM1541 DISK INTERFACE
          VERSION 1.0F

     B - RETURN TO BASIC
     C - CHANGE DEVICE NUMBER
     D - DIRECTORY
     L - LOAD PROGRAM
     S - SAVE PROGRAM
     X - GET DRIVE STATUS
     Z - SEND COMMAND

     DEVICE NUMBER : 8

Description of the menu items:

B - RETURN TO BASIC
Simply quits the interface software returning to BASIC.

C - CHANGE DEVICE NUMBER
Toggles the device number between 8 and 9.
The change is also reflected at the bottom of the menu.
Theoretically two 1541s can be daisy chained but, as I own only one, I changed
jumper wires on the 1541 PCB in order to test the device 9 option.

D - DIRECTORY
Shows the directory of the disk inserted in the currently selected device.
If the screen overflows, a PRESS ANY KEY message will appear at the bottom,
after pressing it, the screen is cleared and the directory continues.

Example of a disk directory.

0 "GAMES 1B        " 55 2A      ;disk name given in the FORMAT command.
9    "BLOCK"            PRG     ;example of program name.
655 BLOCKS FREE                 ;free disk space.

The number at the left of the filename represents the file length in blocks.
The 55 at the right of the diskname is an ID used by copy programs to identify.
the disk, it should be a pair of any alphanumeric characters.
The 2A represents the CBM 1541 internal DOS and must be present on each disk.

L - LOAD PROGRAM
Loads a prgram file into memory and executes it if saved with autorun.
Upon pressing 'L' the filename is prompted, type in the filename and press
<ENTER>. The maximum filename length is 12 characters.

S - SAVE PROGRAM
Saves a program file to disk, programs saved this way will not autorun.
Upon pressing 'S' the filename is prompted, type in the filename and press
<ENTER>. The maximum filename length is 12 characters.

X - GET DRIVE STATUS
Reads the current drive status channel.
If the drive red led blinks due to an error, this command reports the
drive error and resets the drive error condition.
If executed with no error, it will report:
00, OK,00,00
If executed with no disk in the drive it will report
74,DRIVE NOT READY,00,00
If executed as the first command after the drive is turned on it will report
the drive's internal DOS version.
In the case of my 1541, it reports:
73,CBM DOS V2.6 1541,00,00
For more information about the error reports refer to the 1541 user's manual.

Z - SEND COMMAND
Sends a command to the 1541.
Upon pressing 'Z' the command is prompted, type in the command and
press <ENTER>.

Command examples:

FORMAT A DISK
N:DISKNAME,ID,2A
The ID is any combination of two alphanumeric characters.
The 2A identifies disks formatted with the 1541 and must be present.

Recently formatted diskette directory.
0 "DISKNAME        " 55 2A
664 BLOCKS FREE
               
QUICKFORMAT A DISK (ONLY CLEAR THE DIRECTORY)
N:DISKNAME
This only clears the directory, the disk is not actually formatted.

RENAME A FILE
R:NEWNAME=OLDNAME
Changes the name of any file within the disk.

COPY A FILE WITHIN THE SAME DISK
C:NEWFILE=OLDFILE

DELETE A FILE
S:FILENAME

INITIALIZE THE DISK DRIVE
I
Initializes the disk system as it is initialized after power on.

RE-ORGANIZE THE DISKETTE SECTORS (DEFRAG)
V
It's more or less equivalent to the MSDOS defrag command.
If the power fails or an error occurres during this command, all the disk
contents may be lost.


LOADING AND SAVING FROM WITHIN A PROGRAM
------- --- ------ ---- ------ - -------
To load a program from Basic type this line.
LOAD CHR$ USR 8192"FILENAME"

To save a program from Basic type this line.
SAVE CHR$ USR 8192"FILENAME"
The program saved this way will not auto run.

To save a program with autorun, type the save command as a program line.
For example:

9980 SAVE CHR$ USR 8192"FILENAME"
9990 RUN

Then GOTO 9980 to save the program.

To make a disk saved program to load and not run, first type
POKE 16417,1 then load it from the menu or from BASIC.
After loading, a D/0 report will appear, and the program will be loaded
in memory.


TRANSFERING PROGRAMS TO DISK
----------- -------- -- ----
fROM TAPE TO DISK
---- ---- -- ----
Hook up the tape recorder as well as the disk interface and drive.
Use this command to load and not run a tape saved program.
FAST
RAND USR 837
This will give a C/0 report after loading ok.
Search for the save command line within the program, something like this:
3000 SAVE "GAME"
Replace the line with this one:
3000 SAVE CHR$ USR 8192"GAME"
Then GOTO 3000 to save the program to disk (with autorun).

FROM PC TO DISK
---- -- -- ----
There are a lot of ZX81 programs saved in .P format in the Internet.
Two methods to transfer them to 1541 disks are available.

METHOD #1
------ --
Using SAVE1500 and a cable to connect the PC parallel port to the TS1500.
Hook up the cable ,the disk interface and disk drive.
At the TS1500 side follow the same instructions as transfering from tape.
At the PC side SAVE1500 n FILENAME.
Where 'n' is 1, 2 or 3 depending of the LPT port used.
For more info about SAVE1500 and the cable construction, read SAVE1500 docs..

METHOD #2
------ --
Using STAR COMMANDER and a cable to connect the 1541 to the PC parallel port.
Star Commander is a Norton Commander clone that can be downloaded from the
Internet for free, it has CBM1541 support via a special cable.
In the SC manual there are instructions on how to build the cable.
Select unit 8 and transfer .P files directly to the CBM disks.

I really have a third method for those hard to load tapes.
Using a ZX81 emulator for SVI738, I load the ZX program into the MSX memory.
The MSX has a better tape circuit than the TS1500.
The emulator writes .P files to the MSX disks.
Using the PC and Star Commander, I transfer the programs to CBM disks.

UPDATING OR LOADING SOFTWARE INTO THE EEPROM
-------- -- ------- -------- ---- --- ------
Assemble the source or get the ready assembled .P file.
Write enable the EEPROM by placing the jumper cup in the proper postion.
Transfer the .P file using SAVE1500.
The software has an EEPROM programming routine at its very beginning.
After a while, the TS1500 will return to BASIC.
Turn it off, write protect the EEPROM by moving back the jumper cup.
The interface software is now updated.

TECHNICAL INFORMATION
--------- -----------
This interface is intended to be used with a TS1500 or a CZ1500 computer.
Here in Argentina the Timex Sinclair TS1500 was sold with the brand
Czerweny CZ1500, but basically they are the same machine.
To use it with a ZX81 some work around the ROMCS and RAMCS lines has to be
done, perhaps with a couple of PNP transistors.
The interface does not take these lines into account because the CZ1500
has a fully decoded memory map.
The interface software assummes that the display file is fully expanded
and it pokes directly into the screen memory to make it faster.
Some software changes also have to be made for a ZX81 version.

The interface adds 8k of EEPROM in the range 2000H-3FFFH and 32k of
static RAM divided into two 16k pages in the range 8000H-BFFFH
One of the pages is used by the system as a big buffer, and the other page
is for user data.

All the I/O is made through the port 0BFH, it has partial decoding, thus
any port with bit 6 = 0 will satisfy the address decoder.

TS1500 / C1541  Disk drive interface
Port assignment

+---+---+---+---+---+---+---+---+
| 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |   Port 0BFH
+---+---+---+---+---+---+---+---+
  |   |   |   |   |   |   |   |
  |   |   |   |   |   |   |   +--> R/O Busy status line from EEPROM active low
  |   |   |   |   |   |   +------> W/O High ram bank select
  |   |   |   |   |   +----------> W/O Serial reset                 active high
  |   |   |   |   +--------------> W/O Serial attention output      active high
  |   |   |   +------------------> W/O Serial clock output          active high
  |   |   +----------------------> W/O Serial data  output          active high
  |   +--------------------------> R/O Serial clock input           active low
  +------------------------------> R/O Serial data input            active low

Bits 2-7 are used in the same way as in the Commodore 64.
See Commodore 64 Programmer's guide and C64 rom disassembly for more info.
Bit 1 selects the 16k ram bank at address 8000H-BFFFH 0=user 1=system.
Bit 0 returns the state of the EEPROM busy line, used during EEPROM programming
    0=memory busy 1=ready to accept data.

Luis C. Grosso
Rosario, Argentina
ets@ciudad.com.ar (text only - no HTML, please)
