;---------------------------------------------------------------------------
;-- Reto 1-6: Pintar tres líneas de 8 bits en las posiciones (de caracteres)
;--     (0,0), (15, 0) y (31,0)
;---------------------------------------------------------------------------

    org $8000

    ;-- Poner borde negro
    ld a, 0
    out ($FE), a

    ;-- Linea de la izquierda (0,0)
    ld a,$FF
    ld ($4000),a

    ;-- Linea central (15,0)
    ;-- La dirección es 0x4000 + F
    ld ($400F),a

    ;-- Linea de la derecha (31,0)
    ;-- La direccion es 0x4000 + 0x1F
    ld ($401F),a

    ;-- Atributos
    ld a,$3a
    ld ($5800), a  ;-- Linea izquierda
    ld ($580F),a   ;-- Linea central
    ld ($581F), a  ;-- Linea derecha

    ;-- Bucle infinito
inf:
    jr inf

    end $8000

