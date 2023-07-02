;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina CLS
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE

    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Cambiar los atributos de toda la pantalla
    ;-- b3 = 1011 0011
    ;--      FBPP PIII  Flash=on, bright=off, paper=amarillo, ink=magenta
    ld a, $33
    call CLS
 
 inf:
    jr inf


;---------------------------------------------------------------------------
;-- CLS: Borrar la pantalla y establecer los atributos
;--      Combinacion de CLSATT y CLS-DF
;-         
;-- ENTRADAS:
;--    * A: Atributo de pantalla (FBPPPIII) F=Flash, B=Bright, P=paper, I=Ink
;---------------------------------------------------------------------------
CLS:
    ;-- Borrar memoria de video
    ld hl, $4000  ;-- Direccion base de la memoria de video
    ld bc, $1800  ;-- Tamaño de la memoria de video
    ld (hl), l    ;-- Escribir 0 en memoria video
    ld d, h       ;-- de = $4001
    ld e, 1       
    ldir

    ;-- Establecer los atributos
    ld (hl), a
    ld bc, $2ff   ;-- Tamaño memoria atributos
    ldir 

    ;-- Terminar
    ret


    end $8000
  