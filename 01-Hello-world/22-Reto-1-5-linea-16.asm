;---------------------------------------------------------------------
;-- Reto 1-5: Pintar linea horizontal de 16 pixeles y dos colores
;--   (rojo y amarillo)
;---------------------------------------------------------------------

    org $8000

    ;-- Poner borde azul
    ld a, 1
    out ($FE), a

    ;-- Dibujar primer mitad de la linea (8 bits)
    ld a,$ff
    ld ($4000),a

    ;-- Dibujar segunda mita de la linea (8 bits)
    ld ($4001),a

    ;-- Primer segmento rojo (sobre fondo azul)
    ld a, $0a
    ld ($5800), a

    ;-- Segundo segmento amarillo (fondo azul)
    ld a, $0E
    ld ($5801), a

    ;-- Bucle infinito
inf:
    jr inf

    end $8000

