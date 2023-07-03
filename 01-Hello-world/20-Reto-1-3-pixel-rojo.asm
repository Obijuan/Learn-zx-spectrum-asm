;--------------------------------------------
;-- Reto 1-3: Pixel rojo en posicion (7,0)
;--------------------------------------------

    org $8000

    ;-- Poner borde amarillo para ver bien la posicion del pixel
    ;-- (y comprobar que está en 0,0)
    ld a, 6
    out ($FE), a

    ;-- Escribir valor 0x01 en direccion 0x4000
    ld a,$01
    ld ($4000),a

    ;-- Cambiar sus atributos al color rojo
    ;-- Papel: blanco (111)
    ;-- Tinta: roja (002)
    ;-- Valor atributo: 00111010 = $40
    ;-- Direccion memoria atributos: $5800
    ld a, $3a
    ld ($5800), a

    ;-- Bucle infinito
inf:
    jr inf

    end $8000

