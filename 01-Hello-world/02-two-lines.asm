;----------------------------------------------------------------------------
;-- Programa para dibujar dos líneas horizontales, una debajo de la otra
;----------------------------------------------------------------------------

;-- Puerto para el borde
BORDER: EQU $FE

    org $8000

    ;--- Cambiar color del fondo
    ld a, 6
    out (BORDER), a

    ;-- Puntero a la memoria de video
    ld hl, $4000

    ;-- Numero de lineas horizontales a dibujar
    ;-- Entre 1 y 8
    ld b,2
    
loop:
    call lineah

    ;-- Incrementar en 0x100 (256 bytes)
    ;-- Ahí empieza la linea justo debajo
    inc h

    ;-- Una linea menos
    dec b
    jr nz, loop 

    ret


;------------------------------------------------------------
;-- LINEAH: Pintar una linea horizontal
;--
;-- ENTRADAS:
;--   * HL: Puntero a la memoria de video
;-- MODIFICA:
;--   * Registros AF, B
;------------------------------------------------------------
lineah:
    ;-- Guardar direccion inicial
    push hl

    ;-- Guardar bc
    push bc

    ;-- Numero de bytes para completar una linea horizontal 
    ld b, $20

lineah_loop:
    ld a, $ff
    ld (hl), a

    ;-- Pausa para ver la linea dibujarse
    halt

    ;-- Apuntar a la siguiente posicion
    inc hl

    ;-- Decrementar contador de bytes
    dec b

    ld a, b
    or a

    jr nz, lineah_loop

    ;-- Recuperar bc
    pop bc

    ;-- Recuperar direccion inicial
    pop hl

    ;-- Retornar
    ret


    end $8000