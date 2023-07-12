
;-- Colores del ZX Spectrum
;-- Para tinta, papel y borde
BLACK:    EQU 0
BLUE:     EQU 1
RED:      EQU 2
MAGENTA:  EQU 3
GREEN:    EQU 4
CYAN:     EQU 5
YELLOW:   EQU 6
WHITE:    EQU 7

;-- Puerto de salida para establecer el color del borde
BORDER_PORT: EQU $FE

MACRO BORDER ,color
  ld a, color
  out (BORDER_PORT), a
ENDM

MACRO CLS ,paper,ink
  ld a, paper << 3 | ink
  call cls
ENDM



    org $8000

    BORDER RED
    CLS BLACK, GREEN

    ld a, $FF
    ld hl,$4000
    ld (hl),a

inf: jr inf

    include "Video.asm"

    end $8000



    
