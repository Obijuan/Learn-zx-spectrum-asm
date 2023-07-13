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

;-- Campo para acceder al atributo PAPER
PAPER:    EQU 3

;-- Puerto de salida para establecer el color del borde
BORDER_PORT: EQU $FE

;-- Puerto de entrada para leer el teclado
KEY_PORT: EQU $FE

;-------------------------------------------
;-- BORDER: Establecer el color del borde 
;-------------------------------------------
MACRO BORDER ,color
  ld a, color
  out (BORDER_PORT), a
ENDM

;--------------------------------------------------------------
;-- SET_ATTR_S: Establecer los atributos permanente
;-- Se actualiza la variable del sistema ATTR_S
;--------------------------------------------------------------
MACRO SET_ATTR_S ,paper,ink
  ld a, paper << PAPER | ink
  ld hl, ATTR_S
  ld (hl), a 
ENDM

;------------------------------------------------------------------------
;-- CLS(paper, ink): Borrar la pantalla con los attributos indicados 
;------------------------------------------------------------------------
MACRO CLS ,paper,ink
  ld a, paper << 3 | ink
  call cls
ENDM

;---- Memoria de Video: Datos
VIDEORAM:  EQU $4000
VIDEOSIZE: EQU $1800  ;-- Tamaño: 6KB

;---- Memoria de Video: Atributos
VIDEOATTR:     EQU $5800
VIDEATTR_SIZE: EQU $300    ;-- 768 bytes (32*24)

;------------------------------------
;--- VARIABLES DEL SISTEMA
;------------------------------------

;-- Atributos permanentes del sistema. Es lo que se usa cuando se llama 
;-- a CLS
;-- Formato:  Flash, Bright, paper (3-bits), ink (3-bits)
ATTR_S: EQU $5C8D

;-------------------------------------------------
;-- Rutina de CLS en ROM
;-- Altera el valor de los registros AF, BC, DE Y HL
;----------------------------------------------------
ROM_CLS: EQU $0DAF

