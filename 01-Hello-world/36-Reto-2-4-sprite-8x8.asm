;---------------------------------------------------------------------------
;-- Reto 2-4: Animacion de un sprite 8x8
;-- Vesión 2: más optmizada.....
;---------------------------------------------------------------------------

    org $8000


    ;-- Esperar a que el frame actual termine
    halt

    ;-- Fijar los atributos de la primera celda
    ;-- Fondo: blanco, tinta: azul
    ld a, $39
    ld ($5800),a

bucle:
    ;-- Fotograma 0
    ld hl, $4000    ;-- Posicion 0,0
    ld de, sprite_0
    call draw_sprite
    call wait_100ms

    ;-- Fotograma 1
    ld hl, $4000
    ld de, sprite_1
    call draw_sprite
    call wait_100ms

    ;-- Fotograma 2
    ld hl, $4000
    ld de, sprite_2
    call draw_sprite
    call wait_100ms

    ;-- Fotograma 3
    ld hl, $4000
    ld de, sprite_1
    call draw_sprite
    call wait_100ms

    jr bucle

   

;----------------------------------------------------------------------
;-- Dibujar sprite
;--
;-- ENTRADAS:
;--   * HL: Direccion de la memoria de video (Alineada a celda)
;--   * DE: Direccion del sprite
;;---------------------------------------------------------------------
draw_sprite:

    ;-- Numero de bytes del sprite
    ld b, 8

    ;-- Est bucle pinta el sprite
    ;-- byte a byte. Se repite 8 veces
loop:
    ;-- Leer byte
    ld a, (de)

    ;-- Guardarlo en memoria de video
    ld (hl), a 

    ;-- Apuntar al siguient byte del sprite
    inc de

    ;-- Apuntar a la siguiente scanline
    inc h

    ;-- Repetir
    djnz loop


    ret

sprite_0:
    defb $7E, $18, $18, $18, $18, $7E, $3C, $18 

sprite_1:
    defb $00, $7E, $18, $18, $18, $7E, $3C, $18

sprite_2:
    defb $00, $00, $7E, $18, $18, $7E, $3C, $18


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
