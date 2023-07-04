;---------------------------------------------------------------------------
;-- Reto 2-5: Disparo láser con avance de 8 píxeles
;---------------------------------------------------------------------------

    org $8000

start:
    ;-- Posiciones a avanzar la bala
    ld b,20

    ;-- Puntero a la posicion de la bala
    ld hl, $4000

    ;-- Puntero a los atributos de la bala
    ld de, $5800

    ;-- Dibujar la bala inicial
    ld a, $FF
    ld (hl), a

    ;-- Atributos
    ld a, $3a
    ld (de), a

    call wait

bucle:

    ;-- Borrar la bala
    ld a, 0
    ld (hl), a

    ;-- Incrementar posicion y puntero de los atributos
    inc hl
    inc de

    ;-- Dibujar la bala
    ld a, $FF
    ld (hl), a

    ;-- Atributos
    ld a, $3a
    ld (de), a

    call wait

    ;-- Repetir
    djnz bucle

    ;-- Borrar la bala
    ld a,0
    ld (hl), a

    ;-- Espera mayor
    call wait
    call wait
    call wait
    call wait
    call wait
    call wait

    jp start


;---------------------------------------------------------------------------------
;-- Wait 
;--
;--  Se espera a que lleguen N frames. Cada frame llega a los 20ms, por lo que
;--  se hace una espera de unos 100ms
;---------------------------------------------------------------------------------
wait:

    halt  ;-- 20ms
    halt  ;-- 20ms
    halt
    halt
    ret 

    end $8000
