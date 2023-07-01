;-----------------------------------------------------------------------------
;-- Rellenar toda la memoria de video con unos para encender todos
;-- los pixeles
;-----------------------------------------------------------------------------

;-- Puerto para el borde
BORDER: EQU $FE

    org $8000

    ;--- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ld hl, $4000   ;-- Apuntar a la memoria de video

bucle:
    ;-- Activar los 8 pixeles
    ld a, $ff
    ld (hl), a

    ;-- Condicion de terminacion
    ld a, h
    cp $57
    jr nz, next

    ;-- Comprobar si l=0xFF
    ld a, l
    cp $FF
    jr z, fin 

next:
    ;-- Incrementar la direccion
    inc hl

    ;-- Hacer una pausa para ver cómo se rellena
    ;-- la pantalla
    call wait

    ;-- Repetir
    jr bucle

fin:
    jr fin

;-------------------------------
;-- Realizar un pausa
;--------------------------------
wait:
    ld a,$ff
loop:
    dec a
    nop
    jr nz, loop
    ret


    end $8000