;----------------------------------------------------------------------------
;-- Dibujar la primera scanline de cada tercio
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE


    org $8000

    ;--- Poner borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Dibujar la scanline inicial del primer tercio
    ld a,0  ;-- Tercio: 0
    call dir_tercio
    call lineah

    ;-- Dibujar scanline incial del segundo tercio
    ld a,1
    call dir_tercio
    call lineah

    ;-- Dibujar scanline inicial del tercer tercio
    ld a,2
    call dir_tercio
    call lineah

    ret

;------------------------------------------------------------
;-- DIR_TERCIO: Obtener la direccion de memoria de un tercio
;--
;-- ENTRADA:
;--   * A: Numero de tercio (0-2)
;-- DEVUELVE:
;--   * HL: Direccion de memoria
;------------------------------------------------------------
dir_tercio:
    ;-- Desplazar A 3 bits a la izquierda, para colocar el tercio
    add a,a  ; A = 2*A (Desplazamiento de 1 bit a la izquierda)
    add a,a
    add a,a

    ;-- Añadir a A los 3 bits de mayor peso correspondientes
    ;-- a la direccion de la memoria de video (010)
    ld b,a
    ld a, $40
    or b   

    ;-- Meter en HL la direccion de video
    ld h,a
    ld l,0

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