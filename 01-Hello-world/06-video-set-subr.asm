;----------------------------------------------------------------------------
;-- Subrutinas para acceso a las diferentes zonas de la memoria de video
;-- Se parte siempre de una dirección ya inicializada en HL 
;-- (por ejemplo HL = 0x4000)
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE


    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- HL Apunta a la memoria de video
    ld hl, $4000

    ;-- Establecer tercio 2
    ld a, 2
    call set_tercio

    ;-- Pintar
    ld a,$FF
    ld (hl), a

    ;-- Establecer linea 1
    ld a,1
    call set_linea

    ;-- Pintar
    ld a,$FF
    ld (hl), a

    ;- Establecer el scanline 1
    ld a,1
    call set_scanline

    ;-- Pintar
    ld a,$FF
    ld (hl), a

    ;-- Establecer la columna 1
    ld a,1
    call set_col

    ;-- Pintar
    ld a,$FF
    ld (hl), a


    ret



;------------------------------------------------------------
;-- set_tercio: Establecer el tercio a usar
;--
;-- ENTRADA:
;--   * A: Numero de tercio (0-2)
;--   * HL: Direccion de video (cualquiera valida)
;-- DEVUELVE:
;--   * HL: Direccion de memoria
;--
;-- Esta funcion SOLO cambia el campo del tercio, dejando el resto
;-- de los componentes de HL como estaban (scanline, linea, col...)
;-- PPPT TSSS LLLC CCCC
;--
;------------------------------------------------------------
set_tercio:
    ;-- Desplazar A 3 bits a la izquierda, para colocar el tercio
    add a,a  ; A = 2*A (Desplazamiento de 1 bit a la izquierda)
    add a,a
    add a,a

    ;-- B: Numero de tercio ya colocado en su posicion
    ld b, a

    ;-- Dejar en A lo que hay en H pero con los bits T a 0
    ld a,$E7  ;-- Mascara para poner a 0 los bits T de HL
    and h     ;-- A= PPP0 0SSS

    ;-- Añadir a A el numero de tercio
    or b

    ;-- Actualizar la direccion de video
    ;-- L se queda como esta
    ;-- H tiene los nuevos bits de T
    ld h,a

    ret

;------------------------------------------------------------
;-- set_linea: Establecer a linea a usar
;--
;-- ENTRADA:
;--   * A: Numero de linea (0-7)
;--   * HL: Direccion de video (cualquiera valida)
;-- DEVUELVE:
;--   * HL: Direccion de memoria
;--
;-- Esta funcion SOLO cambia el campo de la liena, dejando el resto
;-- de los componentes de HL como estaban (tercio,scanline, col...)
;-- PPPT TSSS LLLC CCCC
;--
;------------------------------------------------------------
set_linea:

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
;-- set_scanline: Establecer el scanline a usar
;--
;-- ENTRADA:
;--   * A: Numero de scanline (0-7)
;--   * HL: Direccion de video (cualquiera valida)
;-- DEVUELVE:
;--   * HL: Direccion de memoria
;--
;-- Esta funcion SOLO cambia el campo del scanline, dejando el resto
;-- de los componentes de HL como estaban (tercio,linea, col...)
;-- PPPT TSSS LLLC CCCC
;--
;------------------------------------------------------------
set_scanline:

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
;-- set_col: Establecer la columna a usar
;--
;-- ENTRADA:
;--   * A: Numero de columna (0-31)
;--   * HL: Direccion de video (cualquiera valida)
;-- DEVUELVE:
;--   * HL: Direccion de memoria
;--
;-- Esta funcion SOLO cambia el campo de la columna, dejando el resto
;-- de los componentes de HL como estaban (tercio,linea, scanline...)
;-- PPPT TSSS LLLC CCCC
;--
;------------------------------------------------------------
set_col:

    ;-- Guardar la columna en b
    ld b,a

    ;-- Poner en A lo que hay en L con los bits C a 0
    ld a, $E0  ;-- Mascara
    and l

    ;-- Añadir el campo de la columna (que esta en b)
    or b

    ;-- Llevar el resultado a l
    ld l, a

    ret

    end $8000