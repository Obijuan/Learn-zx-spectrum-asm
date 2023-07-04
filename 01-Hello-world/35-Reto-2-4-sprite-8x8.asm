;---------------------------------------------------------------------------
;-- Reto 2-4: Animacion de un sprite 8x8
;---------------------------------------------------------------------------

    org $8000


    ;-- Esperar a que el frame actual termine
    halt

    ;-- Fijar los atributos de la primera celda
    ;-- Fondo: blanco, tinta: azul
    ld a, $39
    ld ($5800),a


bucle:
    ;-- Pintar fotograma 1
    ;-- 01111110 = 7E
    ;-- 00011000 = 18
    ;-- 00011000 = 18 
    ;-- 00011000 = 18
    ;-- 00011000 = 18
    ;-- 01111110 = 7E
    ;-- 00111100 = 3C
    ;-- 00011000 = 18

    ld a, $7E
    ld ($4000), a
    ld a, $18
    ld ($4100), a
    ld ($4200), a
    ld ($4300), a
    ld ($4400), a
    ld a, $7E
    ld ($4500), a
    ld a, $3C
    ld ($4600), a
    ld a, $18
    ld ($4700), a

    call wait_100ms

    ;-- Pintar fotograma 2
    ;-- 0000 0000 = 00
    ;-- 0111 1110 = 7E
    ;-- 0001 1000 = 18
    ;-- 0001 1000 = 18
    ;-- 0001 1000 = 18
    ;-- 0111 1110 = 7E
    ;-- 0011 1100 = 3C
    ;-- 0001 1000 = 18

    ld a, $00
    ld ($4000), a
    ld a, $7E
    ld ($4100), a
    ld a, $18
    ld ($4200), a
    ld ($4300), a
    ld ($4400), a
    ld a, $7E
    ld ($4500), a
    ld a, $3C
    ld ($4600), a
    ld a, $18
    ld ($4700), a

    call wait_100ms

    ;-- Pintar fotograma 3
    ;-- 0000 0000 = 00
    ;-- 0000 0000 = 00
    ;-- 0111 1110 = 7E
    ;-- 0001 1000 = 18
    ;-- 0001 1000 = 18
    ;-- 0111 1110 = 7E
    ;-- 0011 1100 = 3C
    ;-- 0001 1000 = 18

    
    ld a, $00
    ld ($4000), a
    ld a, $00
    ld ($4100), a
    ld a, $7E
    ld ($4200), a
    ld a, $18
    ld ($4300), a
    ld ($4400), a
    ld a, $7E
    ld ($4500), a
    ld a, $3C
    ld ($4600), a
    ld a, $18
    ld ($4700), a

    call wait_100ms

    ;-- Pintar de nuevo fotograma 2
    ld a, $00
    ld ($4000), a
    ld a, $7E
    ld ($4100), a
    ld a, $18
    ld ($4200), a
    ld ($4300), a
    ld ($4400), a
    ld a, $7E
    ld ($4500), a
    ld a, $3C
    ld ($4600), a
    ld a, $18
    ld ($4700), a

    call wait_100ms

    jp bucle


;---------------------------------------------------------------------------------
;-- Wait 100ms
;--
;--  Se espera a que lleguen 5 frames. Cada frame llega a los 20ms, por lo que
;--  se hace una espera de unos 100ms
;---------------------------------------------------------------------------------
wait_100ms:

    halt  ;-- 20ms
    halt  ;-- 20ms
    halt  ;-- 20ms
    halt  ;-- 20ms
    halt  ;-- 20ms
    ret 

    end $8000
