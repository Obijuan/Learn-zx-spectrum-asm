;---------------------------------------------------------------------------
;-- Reto 1-10: Bandera cyan-amarilla, de 8x4
;---------------------------------------------------------------------------

;-- Sprite: Cocoball-1
;--
;-- 01111100 = 7C
;-- 10000010 = 82
;-- 10101010 = AA
;-- 10101010 = AA
;-- 10000010 = 82
;-- 10000010 = 82
;-- 01111100 = 7C
;-- 00000000 = 00

;-- Sprite: Cocoball-2
;--
;-- 0111 1100 = 7C
;-- 1111 1110 = FE
;-- 1101 0110 = D6
;-- 1101 0110 = D6
;-- 1111 1110 = FE
;-- 1111 1110 = FE
;-- 0111 1100 = 7C
;-- 0000 0000 = 00

    org $8000

    
    ;--- Dibujar el Sprite en la posicion (0,0)
    ld a, $7C
    ld ($4000), a
    ld a, $82
    ld ($4100), a
    ld a, $AA
    ld ($4200), a
    ld ($4300), a
    ld a, $82
    ld ($4400), a
    ld ($4500), a
    ld a,$7C
    ld ($4600), a
    ld a,$00
    ld ($4700), a

    ;-- Dibujar otro Sprite (cocoball-2) en la posicion (2,0)
    ld a, $7C
    ld ($4002), a
    ld a, $FE
    ld ($4102), a
    ld a, $D6
    ld ($4202), a
    ld ($4302), a
    ld a, $FE
    ld ($4402), a
    ld ($4502), a
    ld a,$7C
    ld ($4602), a
    ld a,$00
    ld ($4702), a
    
    ;-- Atributos. Fondo blanco, color azul
    ;-- 00 111 001 = 0011 1001 = 39
    ld a, $39
    ld ($5800),a
    ld ($5802),a 

    ;-- Bucle infinito
inf:
    jr inf

    end $8000
