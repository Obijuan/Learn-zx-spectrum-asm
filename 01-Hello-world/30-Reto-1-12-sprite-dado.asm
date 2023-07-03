;---------------------------------------------------------------------------
;-- Reto 1-12: Sprite de un dado, con el numero 5 (de 8x8), en posicion 10,15
;---------------------------------------------------------------------------

;-- Sprite: Dado, 5
;--
;-- 11111111 = FF
;-- 10011001 = 99
;-- 11111111 = FF
;-- 11100111 = E7
;-- 11111111 = FF
;-- 10011001 = 99
;-- 11111111 = FF
;-- 11111111 = FF
;--
;-- Atributos: fondo rojo (010). Tinta amarilla (110)
;-- 00 010 110 = 0001 0110 = 16
;-- 
;-- Dir atributos:  5800 + LLLLLCCCCC
;--    Linea 10: 01010 01111 -> 01 0100 1111 = 14F
;--    Col 15:
;--    Dir: 5800 + 14F = 594F

;-- Posicion 10,15:
;--   Linea: 10 --> 01010 (TTLLL) T=01, LLL=010
;--   Colu 15 --->  CCCCC = 01111
;--   Byte bajo: LLLCCCCC = 01001111 = 0100 1111 = 4F
;--   Byte alto: 010TTSSS = 01001000 = 0100 1000 = 48
;--   Direcciones: 4800, 4900, 4A00, 4B00, 4C00, 4D00, 4E00, 4F00

    org $8000

    
    ;--- Dibujar el Sprite
    ld a, $FF
    ld ($484F), a
    ld a, $99
    ld ($494F), a
    ld a, $FF
    ld ($4A4F), a
    ld a, $E7
    ld ($4B4F), a
    ld a, $FF
    ld ($4C4F), a
    ld a, $99
    ld ($4D4F), a
    ld a,$FF
    ld ($4E4F), a
    ld ($4F4F), a
    
    ;-- Atributos
    ld a, $16
    ld ($594F),a 

    ;-- Bucle infinito
inf:
    jr inf

    end $8000
