;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina CLSATT
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
    call CLSATT
 
    ret


;---------------------------------------------------------------------------
;-- CLSATT: Borrar la memoria de atributos escribiendo un valor
;-         
;-- ENTRADAS:
;--    * A: Atributo de pantalla (FBPPPIII) F=Flash, B=Bright, P=paper, I=Ink
;---------------------------------------------------------------------------
CLSATT:
    ;-- Direccion de memoria de atributos
    ld hl, $5800

    ;-- Tamaño de la memoria de atributos
    ld bc, $2ff

    ld (hl), a   ;-- Establecer atributo en la posicion actual
    ld d, h      ;-- de = $5801
    ld e, 1
    ldir 
    
    ;-- Terminar
    ret


    end $8000
