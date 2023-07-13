  include "zxspectrum.h"  

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

  org $8000
  
  ;------------- Pasar a Dark Mode ------------
  BORDER BLACK
  
  ;-- Establecer los atributos permanentes
  SET_ATTR_S BLACK, GREEN

  ;-- Borrar la pantalla
  CALL ROM_CLS
  ;--------------------------------------------

  ;-- Imprimir un caracter
  ld a, 'A'
  rst $10

  ;-- Esperar a que se pulse una tecla cualquiera
  call Wait_Key

  ;-- Imprimir otro caracter
  ld a, 'B'
  rst $10
    
  ;-- Esperar a que se pulse otra tecla
  call Wait_Key

  ;-- Imprimir otro caracter
  ld a, 'C'
  rst $10

  ;-- Terminar
inf: jr inf


    include "Video.asm"
    include "Keyboard.asm"

    end $8000
