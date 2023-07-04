;---------------------------------------------------------------------------
;-- Reto 2-2: Animacion de un pixel a lo largo de 8 posiciones
;---------------------------------------------------------------------------

    org $8000


    ;-- Esperar a que el frame actual termine
    halt

    ;-- Fijar los atributos de la primera celda
    ;-- Fondo: blanco, tinta: roja
    ld a, $3a
    ld ($5800),a

    ;-- Valor inicial: 0x80
    ld a, $80

bucle:

    ;-- Mostrar pixel en posicion actual
    ld ($4000), a
    call wait_100ms

    ;-- Desplazar A un bit a la derecha
    rrca

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
