  include "zxspectrum.h"  

  org $8000
  
  ;-- Entrar en el Dark Mode
  BORDER BLACK
  CLS BLACK, GREEN

  ;-- Led apagado
  ld a, $00
  ld ($4000),a
  ld a, $3C
  ld ($4100),a
  ld a, $42
  ld ($4200),a
  ld a, $42
  ld ($4300),a
  ld a, $42
  ld ($4400),a
  ld a, $42
  ld ($4500),a
  ld a, $3C
  ld ($4600),a
  ld a, $00
  ld ($4700),a
  
  ;-- Led encendido
  ld a, $00
  ld ($4001),a
  ld a, $3C
  ld ($4101),a
  ld a, $7E
  ld ($4201),a
  ld a, $7E
  ld ($4301),a
  ld a, $7A
  ld ($4401),a
  ld a, $76
  ld ($4501),a
  ld a, $3C
  ld ($4601),a
  ld a, $00
  ld ($4701),a
    

inf: jr inf

    include "Video.asm"

    end $8000



    
