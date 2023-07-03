;---------------------------------------------------------------------------
;-- Reto 1-9: Pintar una línea vertical de 4 pixeles
;---------------------------------------------------------------------------

    org $8000

    ;-- Poner borde negro
    ld a, 0
    out ($FE), a

    ;-- La linea la ponemos en la posicion (7,0), para que se vea mejor
    ld a,$01
    ld ($4000),a  ;-- Primer pixel

    ;--- Segundo pixel: (7,1)
    ;--- Byte bajo: LLLCCCCC = 00000000 = 00
    ;--- Byte alto: 010TTSSS = 01000001 = 41
    ld ($4100), a 

    ;--- Tercer pixel: (7,2)
    ;-- Mismo byte bajo: 00
    ;-- Byte alto: 01000010 = 42
    ld ($4200), a

    ;-- Cuarto pixel: (7,3)
    ;-- Mismo byte bajo: 00
    ;-- Byte alto: 01000011 = 42
    ld ($4300), a

    ;-- Atributos
    ld a,$3a
    ld ($5800), a  

    ;-- Bucle infinito
inf:
    jr inf

    end $8000
