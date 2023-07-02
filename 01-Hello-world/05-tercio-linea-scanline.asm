;-------------------------------------------------------------
;-- Dibujar las lineas indicadas dentro del tercio actual
;-------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE


    org $8000

    ;--- Poner borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Dibujar lineas de separacion entre los tercios, para
    ;-- comprobar que las lineas siguientes estan ok
    call split_tercios

    ;-- HL: Obtener la direccion del tercio en cuestion
    ld a,0  ;-- Tercio: 0
    call dir_tercio

    ;-- Pintar en diferentes lineas    

    ;-- Indicar linea a pintar (0-7)
    ld a,1
    call offset_linea
    call lineah   ;-- Se pinta el primer scanline (0)

    ;-- Pintar varios scanlines consecutivos

    ;-- Establecer la scanline a pintar
    ld a,1  ;-- Scanline 1
    call offset_scanline
    call lineah

    ld a,2 ;-- Scanline 2
    call offset_scanline
    call lineah

    ret

;---------------------------------------------------------
;-- Dibujar las 3 lineas de separacion de los tercios 
;---------------------------------------------------------
split_tercios:

    ;--- Linea de tercio 0
    ld a,0
    call dir_tercio
    call lineah

    ;-- Linea de tercio 1
    ld a,1
    call dir_tercio
    call lineah

    ;-- Linea de tercio 2
    ld a,2
    call dir_tercio
    call lineah

    ret

;-------------------------------------------------------------
;-- OFFSET_SCANLINE: Obtener la nueva direccion correspondiente
;-   al scanline indicado de la linea actual en el tercio actual
;--
;-- ENTRADAS:
;--   HL: Direccion base del tercio actual
;--   A: Scanline a dibujar
;--
;-- SALIDAS:
;--   HL: Nueva direccion de la memoria de video
;----------------------------------------------------------------
offset_scanline:

    ;-- El scanline lo metemos en b para no perderlo
    ld b,a

    ;-- Borrar los 3 bits de menor peso de H (SSS)
    ;-- El resultado en A
    ld a,$f8
    and h

    ;-- Añadir el scanline a A
    or b

    ;-- Llevarlo a H
    ld h,a

    ret

;------------------------------------------------------------
;-- OFFSET_LINEA: Obtener la nueva direccion correspondiente 
;-- a la linea indicada en el tercio actual
;--
;-- ENTRADAS:
;--   HL: Direccion base del tercio actual
;--   A: Linea a dibujar (0-7)
;--
;-- SALIDA:
;--   HL: Nueva direccion de la memoria de video
;------------------------------------------------------------
offset_linea:

    ;-- Hay que desplazarlo 5 bits a la izquierda
    add a,a
    add a,a
    add a,a
    add a,a
    add a,a

    ;-- Esto es el nuevo byte bajo de HL
    ld l,a

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