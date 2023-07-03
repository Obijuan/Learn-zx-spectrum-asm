;---------------------------------------------------------------------
;-- Reto 1-5: Pintar linea horizontal de 16 pixeles y dos colores
;--   (rojo y amarillo)
;---------------------------------------------------------------------

    org $8000

    ;-- Poner borde azul
    ld a, 1
    out ($FE), a

    ;-- Dibujar las dos mitadas. L=bits de 0x4000. H=bits de 0x4001
    ld hl,$ffff
    ld ($4000),hl

    ;-- Almacenar los dos atributos de un golpe
    ;-- L->Atributo de la primera mitad: Rojo sobre fondo azul
    ;-- H->Atributo de la segunda mitad: Amarillo sobre fondo azul
    ld hl, $0e0a
    ld ($5800), hl

    ;-- Bucle infinito
inf:
    jr inf

    end $8000

