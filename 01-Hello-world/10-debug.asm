;----------------------------------------------------------------------------
;-- Ejemplo de depuración
;----------------------------------------------------------------------------

    org $8000

inicio:

    ld hl, $4000
    ld de, $8100
    ld a, 0

bucle:
    halt
    halt
    halt
    halt
    ld (hl), a
    ld (de), a
    inc a
    jr nc, bucle

fin:

    jr inicio

    end $8000