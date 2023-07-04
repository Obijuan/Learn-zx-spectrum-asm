;---------------------------------------------------------------------------
;-- Reto 2-1: Animacion de un pixel a lo largo de 4 posiciones
;---------------------------------------------------------------------------

    org $8000


    ;-- Esperar a que el frame actual termine
    halt

    ;-- Fijar los atributos de la primera celda
    ;-- Fondo: blanco, tinta: roja
    ld a, $3a
    ld ($5800),a

bucle:

    ;-- Pixel en posicion (0,0)
    ld a, $80
    ld ($4000), a
    call wait_100ms

    ;-- Pixel en posicion (1,0)
    ld a, $40
    ld ($4000), a
    call wait_100ms

    ;-- Pixel en posicion (2,0)
    ld a, $20
    ld ($4000), a
    call wait_100ms

    ;-- Pixel en posicion (3,0)
    ld a, $10
    ld ($4000), a
    call wait_100ms

    ;-- Repetir
    jr bucle

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
