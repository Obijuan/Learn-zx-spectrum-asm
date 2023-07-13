  include "zxspectrum.h"  

  org $8000
  
  ;------------- Pasar a Dark Mode ------------
  BORDER BLACK
  
  ;-- Establecer los atributos permanentes
  SET_ATTR_S BLACK, GREEN

  ;-- Borrar la pantalla
  CALL ROM_CLS
  ;--------------------------------------------

  loop:
    
    ;-- Apagar led
    call led_off

    ;-- Esperar a que se pulse una tecla
    call Wait_Key

    ;-- Encender led
    call led_on

    ;-- Esperar a que se pulse una tecla
    call Wait_Key

    jr loop


led_off:
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
  ret
  

led_on:
  ;-- Led encendido
  ld a, $00
  ld ($4000),a
  ld a, $3C
  ld ($4100),a
  ld a, $7E
  ld ($4200),a
  ld a, $7E
  ld ($4300),a
  ld a, $7A
  ld ($4400),a
  ld a, $76
  ld ($4500),a
  ld a, $3C
  ld ($4600),a
  ld a, $00
  ld ($4700),a
  ret


  ;-- Terminar
inf: jr inf


    include "Video.asm"
    include "Keyboard.asm"

    end $8000
