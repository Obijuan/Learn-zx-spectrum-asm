;--------------------------------------------
;-- Reto 1: Pixel negro en posicion (1,0)
;--------------------------------------------

    org $8000

    ;-- Poner borde amarillo para ver bien la posicion del pixel
    ;-- (y comprobar que está en 0,0)
    ld a, 6
    out ($FE), a

    ;-- Escribir valor 0x40 en direccion 0x4000
    ld a,$40
    ld ($4000),a

    ;-- Bucle infinito
inf:
    jr inf

    end $8000

