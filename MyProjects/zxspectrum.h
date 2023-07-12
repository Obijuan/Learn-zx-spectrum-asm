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

;-------------------------------------------
;-- BORDER: Establecer el color del borde 
;-------------------------------------------
MACRO BORDER ,color
  ld a, color
  out (BORDER_PORT), a
ENDM

;------------------------------------------------------------------------
;-- CLS(paper, ink): Borrar la pantalla con los attributos indicados 
;------------------------------------------------------------------------
MACRO CLS ,paper,ink
  ld a, paper << 3 | ink
  call cls
ENDM


