;---------------------------------------------------------------------------
;-- Reto 1-8: Pintar 3 líneas rojas de 8 bits en la línea 2, encima de los
;--           caracteres B, H y o
;---------------------------------------------------------------------------

    org $8000

    ;-- Poner borde negro
    ld a, 0
    out ($FE), a

    ;-- Linea encima de B: (0,1)
    ;-- LLLCCCCC = 001 00000 (Y=1, x=0)
    ld a, $FF
    ld ($4020),a

    ;-- Linea encima de H: (7,1)
    ;-- LLLCCCCC = 001 00111 = 0010 0111 = 27
    ld ($4027),a

    ;-- Linea encima de o: (15,1)
    ;-- LLLCCCCC = 001 01111 = 0010 1111 = 2F
    ld ($402F),a

    ;-- Atributos
    ld a,$3a
    ld ($5820), a  ;-- Linea B
    ld ($5827), a  ;-- Linea H
    ld ($582F), a  ;-- Linea o

    ;-- Bucle infinito
inf:
    jr inf

    end $8000
