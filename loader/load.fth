." powerpc-ofw-boot : Booting through OpenFirmware..." cr
\ storing 0xBE for beige, 0x5A for mac99
\ cannot use superior, inferior, different symbols (bootinfo.txt)
: sup - dup abs = ;
: inf dup sup 1 + ; 
: diff = if 0 else -1 then ;

: fba frame-buffer-adr ;
: beige-vram 80000000 ; : mac99-vram 81000000 ;

: beige-error ." G3 Beige machine is not supported yet. Please run it with a post-1999 PowerPC Mac." ;
: hardware-error ." Hardware not supported." ;
variable run 
-1 run !

fba beige-vram = if beige-error cr 100 0 do 0BE i beige-vram + c! loop then 
fba mac99-vram = if ." mac99"   cr 100 0 do 05A i mac99-vram + c! loop then
fba beige-vram diff fba mac99-vram diff and if hardware-error cr 0 run ! then

run @ 0 = if 1 0 do 0 +loop then

boot hd:,\boot\kernel.elf
