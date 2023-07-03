;---------------------------------------------------------------------------
;-- Reto 1-7: Pintar 3 líneas rojas de 8 bits en la línea 2, debajo de los
;--           caracteres B, H y o
;---------------------------------------------------------------------------

    org $8000

    ;-- Poner borde negro
    ld a, 0
    out ($FE), a

    ;-- Linea debajo de B: (0,2)
    ;-- LLLCCCCC = 010 00000 (Y=2, x=0)
    ld a, $FF
    ld ($4040),a

    ;-- Linea debajo de H: (7,2)
    ;-- LLLCCCCC = 010 00111 = 0100 0111 = 47
    ld ($4047),a

    ;-- Linea debajo de o: (15,2)
    ;-- LLLCCCCC = 010 01111 = 0100 1111 = 4F
    ld ($404F),a

    ;-- Atributos
    ld a,$3a
    ld ($5840), a  ;-- Linea B
    ld ($5847), a  ;-- Linea H
    ld ($584F), a  ;-- Linea o

    ;-- Bucle infinito
inf:
    jr inf

    end $8000

 (0,2), (7,2) y (15,2)